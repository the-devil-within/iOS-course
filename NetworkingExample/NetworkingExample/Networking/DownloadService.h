//
//  DownloadService.h
//  NetworkingExample
//
//  Created by Blinov on 30.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Track, Download;
@interface DownloadService : NSObject
@property (nonatomic, strong) NSURLSession *downloadsSession;
@property (nonatomic, strong) NSMutableDictionary <NSURL *, Download *> *activeDownloads;

- (void)cancelDownload:(Track *)track;
- (void)pauseDownload:(Track *)track;
- (void)resumeDownload:(Track *)track;
- (void)startDownload:(Track *)track;
@end
