//
//  SearchViewController.m
//  NetworkingExample
//
//  Created by Blinov on 30.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "SearchViewController.h"
#import "Track.h"
#import "TrackCell.h"
#import "TrackCellDelegate.h"
#import "DownloadService.h"
#import "QueryService.h"
#import <AVKit/AVKit.h>

@interface SearchViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, TrackCellDelegate>
@property (nonatomic, strong) NSArray <Track *> *searchResults;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) NSURL *documentsPath;

@property (nonatomic, strong) DownloadService *downloadService;
@property (nonatomic, strong) QueryService *queryService;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (NSURL *)localFilePathForUrl:(NSURL *)url {
    return [self.documentsPath URLByAppendingPathComponent:url.lastPathComponent];
}

- (void)play:(Track *)track {
    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    [self presentViewController:playerViewController animated:YES completion:nil];
    
    NSURL *url = [self localFilePathForUrl:track.previewURL];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    playerViewController.player = player;
    [player play];
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)positioning {
    return UIBarPositionTopAttached;
}

- (void)reload:(NSInteger)row {
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (NSURL *)documentsPath {
    if (!_documentsPath) {
        _documentsPath = [[NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    }
    return _documentsPath;
}

- (UITapGestureRecognizer *)tapRecognizer {
    if (!_tapRecognizer) {
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    }
    return _tapRecognizer;
}

- (void)dismissKeyboard {
    [self.searchBar resignFirstResponder];
}

#pragma mark - Search Bar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self dismissKeyboard];
    NSString *searchText = searchBar.text;
    if (!searchText && [searchText isEqualToString:@""]) {
        return;
    }
    
    UIApplication.sharedApplication.networkActivityIndicatorVisible = YES;
    SearchViewController __weak *welf = self;
    [self.queryService getSearchResultsWithQuery:searchText completion:^(NSArray<Track *> *tracks, NSString *errorMessage) {
        UIApplication.sharedApplication.networkActivityIndicatorVisible = NO;
        if (tracks == nil && (tracks.count == 0)) {
            if (![errorMessage isEqualToString:@""]) {
                NSLog(@"Search error: %@", errorMessage);
            }
        }
        welf.searchResults = tracks;
        [welf.tableView reloadData];
        [welf.tableView setContentOffset:CGPointZero animated:NO];
    }];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.view addGestureRecognizer:self.tapRecognizer];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.view removeGestureRecognizer:self.tapRecognizer];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TrackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackCell" forIndexPath:indexPath];
    
    cell.delegate = self;
    Track *track = self.searchResults[indexPath.row];
    [cell configureWithTrack:track downloaded:track.downloaded];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //When user taps cell, play the local file, if it's downloaded.
    Track *track = self.searchResults[indexPath.row];
    
    if (track.downloaded) {
        [self play:track];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}

#pragma mark - TrackCellDelegate

- (void)cancelTapped:(TrackCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (!indexPath) { return; }
    Track *track = self.searchResults[indexPath.row];
    [self.downloadService cancelDownload:track];
    [self reload:indexPath.row];
}

- (void)downloadTapped:(TrackCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (!indexPath) { return; }
    Track *track = self.searchResults[indexPath.row];
    [self.downloadService startDownload:track];
    [self reload:indexPath.row];
}

- (void)pauseTapped:(TrackCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (!indexPath) { return; }
    Track *track = self.searchResults[indexPath.row];
    [self.downloadService pauseDownload:track];
    [self reload:indexPath.row];
}

- (void)resumeTapped:(TrackCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (!indexPath) { return; }
    Track *track = self.searchResults[indexPath.row];
    [self.downloadService resumeDownload:track];
    [self reload:indexPath.row];
}

@end
