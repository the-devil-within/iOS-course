//
//  MoviesTableViewController.m
//  Kinopoisk
//
//  Created by Blinov on 17.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "MoviesTableViewController.h"
#import "MovieTableViewController.h"
#import "MoviesModel.h"
#import "MovieCell.h"
#import "MovieItem.h"

static NSString *const kCellIdentifier = @"MovieCell";
static NSString *const kShowMovieSegue = @"ShowMovie";

@interface MoviesTableViewController ()
@property (nonatomic, strong) MoviesModel *model;
@end

@implementation MoviesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRefreshControl];
    [self reloadData];
}

- (void)addRefreshControl {
    self.tableView.refreshControl = [UIRefreshControl new];
    self.tableView.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Loading..."];
    [self.tableView.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
}

- (void)reloadData {
    [self.tableView.refreshControl beginRefreshing];
    __weak MoviesTableViewController *welf = self;
    VoidBlock completion = ^{
        [welf.tableView reloadData];
        [welf.tableView.refreshControl endRefreshing];
    };
    
    [self.model loadMoviesWithCompletion:completion];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model moviesCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    MovieItem *movie = [self.model movieAtIndex:indexPath.row];
    
    [self configureCell:cell withMovie:movie];
    
    return cell;
}

- (void)configureCell:(MovieCell *)cell withMovie:(MovieItem *)movie {
    cell.movieTitle.text = movie.movieTitle;
    cell.movieDescription.text = movie.movieDescription;
    cell.poster.image = [UIImage imageNamed:movie.imageName];
}

- (MoviesModel *)model {
    if (!_model) {
        _model = [[MoviesModel alloc] init];
    }
    return _model;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  UITableViewAutomaticDimension;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(MovieCell *)sender {
    if ([segue.identifier isEqualToString:kShowMovieSegue]) {
        MovieTableViewController *vc = segue.destinationViewController;
        vc.movie = [self.model movieAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end
