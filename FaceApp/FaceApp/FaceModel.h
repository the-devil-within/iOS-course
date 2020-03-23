//
//  FaceModel.h
//  FaceApp
//
//  Created by Blinov on 23.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MouthState) {
    MouthStateNeutral,
    MouthStateFrown,
    MouthStateSmile
};

@interface FaceModel : NSObject

@property (nonatomic, assign) BOOL eyesOpen;
@property (nonatomic, assign) MouthState mouthState;

- (instancetype)initWithEyes:(BOOL)eyes mouthState:(MouthState)mouthState;

@end
