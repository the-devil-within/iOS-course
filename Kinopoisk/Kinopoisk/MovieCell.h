//
//  MovieCell.h
//  Kinopoisk
//
//  Created by Blinov on 17.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *poster;
@property (nonatomic, weak) IBOutlet UILabel *movieTitle;
@property (nonatomic, weak) IBOutlet UILabel *movieDescription;

@end
