//
//  TrackCellDelegate.h
//  NetworkingExample
//
//  Created by Blinov on 30.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TrackCell;
@protocol TrackCellDelegate <NSObject>
- (void)cancelTapped:(TrackCell *)cell;
- (void)downloadTapped:(TrackCell *)cell;
- (void)pauseTapped:(TrackCell *)cell;
- (void)resumeTapped:(TrackCell *)cell;
@end
