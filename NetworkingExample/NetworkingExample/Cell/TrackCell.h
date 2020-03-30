//
//  TrackCell.h
//  NetworkingExample
//
//  Created by Blinov on 30.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TrackCellDelegate;
@class Track;

@interface TrackCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *artistLabel;
@property (nonatomic, weak) IBOutlet UILabel *progressLabel;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;
@property (nonatomic, weak) IBOutlet UIButton *downloadButton;
@property (nonatomic, weak) IBOutlet UIButton *pauseButton;
@property (nonatomic, weak) IBOutlet UIProgressView *progressView;

@property (nonatomic, weak) id<TrackCellDelegate> delegate;
- (void)configureWithTrack:(Track *)track downloaded:(BOOL)isDownloaded;
@end


