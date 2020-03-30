//
//  Track.m
//  NetworkingExample
//
//  Created by Blinov on 30.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "Track.h"

@implementation Track

- (instancetype)initWithName:(NSString *)name artist:(NSString *)artist previewURL:(NSURL *)previewURL index:(int)index {
    self = [super init];
    if (self) {
        _name = name;
        _artist = artist;
        _previewURL = previewURL;
        _index = index;
        _downloaded = NO;
    }
    return self;
}

@end
