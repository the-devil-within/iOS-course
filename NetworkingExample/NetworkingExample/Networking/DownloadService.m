//
//  DownloadService.m
//  NetworkingExample
//
//  Created by Blinov on 30.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "DownloadService.h"
#import "Track.h"
#import "Download.h"

@interface DownloadService ()
@end

@implementation DownloadService

- (void)cancelDownload:(Track *)track {
    Download *download = self.activeDownloads[track.previewURL];
    [download.task cancel];
    self.activeDownloads[track.previewURL] = nil;
}

- (void)pauseDownload:(Track *)track {
    Download *download = self.activeDownloads[track.previewURL];
    if (download.isDownloading) {
        [download.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            download.resumeData = resumeData;
        }];
        download.isDownloading = NO;
    }
}

- (void)resumeDownload:(Track *)track {
    Download *download = self.activeDownloads[track.previewURL];
    if (download.resumeData) {
        download.task = [self.downloadsSession downloadTaskWithResumeData:download.resumeData];
    } else {
        download.task = [self.downloadsSession downloadTaskWithURL:download.track.previewURL];
    }
    [download.task resume];
    download.isDownloading = YES;
}

- (void)startDownload:(Track *)track {
    Download *download = [[Download alloc] initWithTrack:track];
    download.task = [self.downloadsSession downloadTaskWithURL:download.track.previewURL];
    [download.task resume];
    download.isDownloading = YES;
    self.activeDownloads[download.track.previewURL] = download;
}

- (NSMutableDictionary<NSURL *,Download *> *)activeDownloads {
    if (!_activeDownloads) {
        _activeDownloads = [NSMutableDictionary new];
    }
    return _activeDownloads;
}

@end
