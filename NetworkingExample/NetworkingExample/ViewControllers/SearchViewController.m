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
#import "AppDelegate.h"
#import "Download.h"

@interface SearchViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, TrackCellDelegate, NSURLSessionDelegate, NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSArray <Track *> *searchResults;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) NSURL *documentsPath;  // Get local file path: download task stores tune here; AV player plays it.

@property (nonatomic, strong) DownloadService *downloadService;
@property (nonatomic, strong) QueryService *queryService;
@property (nonatomic, strong) NSURLSession *downloadsSession;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.downloadService.downloadsSession = self.downloadsSession;
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

- (DownloadService *)downloadService {
    if (!_downloadService){
        _downloadService = [DownloadService new];
    }
    return _downloadService;
}

- (QueryService *)queryService {
    if (!_queryService) {
        _queryService = [QueryService new];
    }
    return _queryService;
}

-(NSURLSession *)downloadsSession {
    if(!_downloadsSession) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.thedemonswithin.networkingExample.bgSession"];
        _downloadsSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _downloadsSession;
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
    [cell configureWithTrack:track downloaded:track.downloaded download:self.downloadService.activeDownloads[track.previewURL]];
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

#pragma mark - NSURLSessionDelegate
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
        VoidBlock completionHandler = appDelegate.backgroundSessionCompletionHandler;
        appDelegate.backgroundSessionCompletionHandler = nil;
        completionHandler();
    });
}

#pragma mark - URLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSURL *sourceURL = downloadTask.originalRequest.URL;
    if (!sourceURL) { return; }
    
    Download *download = self.downloadService.activeDownloads[sourceURL];
    self.downloadService.activeDownloads[sourceURL] = nil;
    
    NSURL *destinationUrl = [self localFilePathForUrl:sourceURL];
    NSFileManager *fm = NSFileManager.defaultManager;
    [fm removeItemAtURL:destinationUrl error:nil];
    [fm copyItemAtURL:location toURL:destinationUrl error:nil];
    download.track.downloaded = YES;
    
    int index = download.track.index;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reload:index];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    NSURL *url = downloadTask.originalRequest.URL;
    if (!url) { return; }
    Download *download = self.downloadService.activeDownloads[url];
    download.progress = (CGFloat)totalBytesWritten / (CGFloat)totalBytesExpectedToWrite;
    
    
    NSString *totalSize = [NSByteCountFormatter stringFromByteCount:totalBytesExpectedToWrite countStyle:NSByteCountFormatterCountStyleFile];
    dispatch_async(dispatch_get_main_queue(), ^{
        TrackCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:download.track.index inSection:0]];
        [cell updateDisplayProgress:download.progress totalSize:totalSize];
    });
}

@end
