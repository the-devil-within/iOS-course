//
//  Download.h
//  NetworkingExample
//
//  Created by Blinov on 30.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Track;
@interface Download : NSObject
@property (nonatomic, assign) BOOL isDownloading;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) NSData *resumeData;
@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic, strong) Track *track;

-(instancetype)initWithTrack:(Track *)track;
@end
