//
//  Download.m
//  NetworkingExample
//
//  Created by Blinov on 30.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "Download.h"
#import "Track.h"

@implementation Download
-(instancetype)initWithTrack:(Track *)track {
    self = [super init];
    if (self) {
        _progress = 0;
        _isDownloading = NO;
        _track = track;
    }
    return self;
}
@end
