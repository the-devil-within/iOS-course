//
//  MovieTableViewController.m
//  Kinopoisk
//
//  Created by Blinov on 27.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "MovieTableViewController.h"
#import "DetailedMovieCell.h"
#import "MovieItem.h"

static NSString *const kCellIdentifier = @"DetailedMovieCell";

@interface MovieTableViewController ()

@end

@implementation MovieTableViewController

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailedMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell];
    return cell;
}

- (void)configureCell:(DetailedMovieCell *)cell {
    cell.poster.image = [UIImage imageNamed:self.movie.imageName];
    cell.movieTitle.text = self.movie.movieTitle;
    cell.movieDescription.text = self.movie.movieDescription;
    cell.date.text = [NSString stringWithFormat:@"Year: %@", self.movie.date];
}

@end
