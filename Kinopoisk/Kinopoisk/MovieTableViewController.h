//
//  MovieTableViewController.h
//  Kinopoisk
//
//  Created by Blinov on 27.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieItem;

@interface MovieTableViewController : UITableViewController
@property (nonatomic, weak) MovieItem *movie;
@end
