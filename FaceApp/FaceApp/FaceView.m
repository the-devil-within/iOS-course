//
//  FaceView.m
//  FaceApp
//
//  Created by Blinov on 28.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "FaceView.h"

static CGFloat const eyeOffsetRadius = 3.0;
static CGFloat const scullRadiusToEyeRadius = 9.0;
static CGFloat const scullRadiusToMouthOffset = 3.0;
static CGFloat const scullRadiusToMouthWidth = 1.0;
static CGFloat const scullRadiusToMouthHeight = 3.0;

@implementation FaceView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _multiplier = 0.95;
        _mouthLevel = 1.0;
        _mainColor = UIColor.blueColor;
        _lineWidth = 5.0;
    }
    return self;
}

- (void)setMultiplier:(CGFloat)multiplier {
    _multiplier = multiplier;
    [self setNeedsDisplay];
}

-(void)setMainColor:(UIColor *)mainColor {
    _mainColor = mainColor;
    [self setNeedsDisplay];
}

- (void)setMouthLevel:(CGFloat)mouthLevel {
    _mouthLevel = mouthLevel;
    [self setNeedsDisplay];
}

-(void)setEyesOpen:(BOOL)eyesOpen {
    _eyesOpen = eyesOpen;
    [self setNeedsDisplay];
}

- (CGPoint)scullCenter {
    return CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}

- (CGFloat)scullRadius {
    return MIN(self.bounds.size.width, self.bounds.size.height)/2 * self.multiplier;
}

- (void)drawRect:(CGRect)rect {
    [self.mainColor setStroke];
    [[self pathForScull] stroke];
    [[self pathForEyeIsRight:YES] stroke];
    [[self pathForEyeIsRight:NO] stroke];
    [[self pathForMouth] stroke];
}

- (UIBezierPath *)pathForScull {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:[self scullCenter] radius:[self scullRadius] startAngle:0 endAngle:2*M_PI clockwise:YES];
    path.lineWidth = self.lineWidth;
    return path;
}

- (UIBezierPath *)pathForEyeIsRight:(BOOL)isRight {
    CGFloat eyeOffset = [self scullRadius]/eyeOffsetRadius;
    CGPoint eyeCenter = CGPointMake(isRight ? [self scullCenter].x +eyeOffset : [self scullCenter].x - eyeOffset, [self scullCenter].y - eyeOffset);
    CGFloat eyeRadius = [self scullRadius]/scullRadiusToEyeRadius;
    UIBezierPath *path;
    
    if (self.isEyesOpen) {
        path = [UIBezierPath bezierPathWithArcCenter:eyeCenter radius:eyeRadius startAngle:0 endAngle:2*M_PI clockwise:YES];
    } else {
        path = [UIBezierPath new];
        [path moveToPoint:CGPointMake(eyeCenter.x - eyeRadius, eyeCenter.y)];
        [path addLineToPoint:CGPointMake(eyeCenter.x + eyeRadius, eyeCenter.y)];

    }
    path.lineWidth = self.lineWidth;
    return path;
}


- (UIBezierPath *)pathForMouth {
    CGFloat mouthYOffset = [self scullCenter].y + [self scullRadius]/scullRadiusToMouthOffset;
    CGPoint mouthCenter = CGPointMake([self scullCenter].x,  mouthYOffset);
    CGFloat mouthWidth = [self scullRadius] / scullRadiusToMouthWidth;
    CGFloat mouthHeight = [self scullRadius] / scullRadiusToMouthHeight;
    CGRect mouthRect = CGRectMake(mouthCenter.x - mouthWidth/2, mouthYOffset - mouthHeight/2, mouthWidth,  mouthHeight);
    CGPoint firstPoint = CGPointMake(mouthRect.origin.x, mouthRect.origin.y + mouthHeight/2);
    CGPoint lastPoint = CGPointMake(firstPoint.x + mouthWidth, mouthRect.origin.y + mouthHeight/2);
    
    CGFloat correctValue = MIN(1, MAX(-1, self.mouthLevel));
    CGPoint controlPoint1 = CGPointMake(firstPoint.x + mouthWidth * 1/3, correctValue * mouthHeight + firstPoint.y);
    CGPoint controlPoint2 = CGPointMake(firstPoint.x + mouthWidth * 2/3, correctValue * mouthHeight + firstPoint.y);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:firstPoint];
    [path addCurveToPoint:lastPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    path.lineWidth = self.lineWidth;
    return path;
}

@end
