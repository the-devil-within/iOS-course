//
//  FaceView.h
//  FaceApp
//
//  Created by Blinov on 28.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface FaceView : UIView

@property (nonatomic) IBInspectable CGFloat mouthLevel; // -1.0 for sad and 1.0 for smile
@property (nonatomic) IBInspectable CGFloat multiplier;
@property (nonatomic) IBInspectable UIColor *mainColor;
@property (nonatomic) IBInspectable CGFloat lineWidth;
@property (nonatomic, getter=isEyesOpen) IBInspectable BOOL eyesOpen;

@end

NS_ASSUME_NONNULL_END
