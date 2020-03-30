//
//  TrackCell.m
//  NetworkingExample
//
//  Created by Blinov on 30.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "TrackCell.h"
#import "Track.h"
#import "TrackCellDelegate.h"

@implementation TrackCell

- (IBAction)cancelTapped:(UIButton *)sender {
    [self.delegate cancelTapped:self];
}

- (IBAction)downloadTapped:(UIButton *)sender {
    [self.delegate downloadTapped:self];
}

- (IBAction)pauseOrResumeTapped:(UIButton *)sender {
    if ([self.pauseButton.titleLabel.text isEqualToString:@"Pause"]) {
        [self.delegate pauseTapped:self];
    } else {
        [self.delegate resumeTapped:self];
    }
}


- (void)configureWithTrack:(Track *)track downloaded:(BOOL)isDownloaded {
    self.titleLabel.text = track.name;
    self.artistLabel.text = track.artist;
    self.selectionStyle = isDownloaded ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
    self.downloadButton.hidden = isDownloaded;

}

@end
