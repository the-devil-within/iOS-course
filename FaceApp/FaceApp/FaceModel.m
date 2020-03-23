//
//  FaceModel.m
//  FaceApp
//
//  Created by Blinov on 23.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "FaceModel.h"

@implementation FaceModel

- (instancetype)initWithEyes:(BOOL)eyes mouthState:(MouthState)mouthState {
    self = [super init];
    if (self) {
        _eyesOpen = eyes;
        _mouthState = mouthState;
    }
    return self;
}

@end
