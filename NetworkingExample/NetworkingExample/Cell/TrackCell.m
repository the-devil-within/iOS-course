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
#import "Download.h"

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


- (void)configureWithTrack:(Track *)track downloaded:(BOOL)isDownloaded download:(Download *)download {
    self.titleLabel.text = track.name;
    self.artistLabel.text = track.artist;
    
    BOOL showDownloadControls = NO;    // Show/hide download controls Pause/Resume, Cancel buttons, progress info.
    
    if (download != nil) {
        showDownloadControls = YES;
        NSString *title = download.isDownloading ? @"Pause" : @"Resume";
        [self.pauseButton setTitle:title forState:UIControlStateNormal];
        self.progressLabel.text = download.isDownloading ? @"Downloading..." : @"Paused";

    }
    
    self.pauseButton.hidden = !showDownloadControls;
    self.cancelButton.hidden = !showDownloadControls;
    
    self.progressView.hidden = !showDownloadControls;
    self.progressLabel.hidden = !showDownloadControls;
    
    
    self.selectionStyle = isDownloaded ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
    self.downloadButton.hidden = isDownloaded || showDownloadControls;
}

- (void)updateDisplayProgress:(CGFloat)progress totalSize:(NSString *)totalSize {
    self.progressView.progress = progress;
    self.progressLabel.text = [NSString stringWithFormat:@"%.1f%% of %@", progress * 100, totalSize];
}

@end
