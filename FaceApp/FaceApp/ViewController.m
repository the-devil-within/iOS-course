//
//  ViewController.m
//  FaceApp
//
//  Created by Blinov on 28.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "ViewController.h"
#import "FaceView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet FaceView *faceView;
@end

@implementation ViewController

- (void)setFaceView:(FaceView *)faceView {
    _faceView = faceView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    tap.numberOfTouchesRequired = 1;
    [faceView addGestureRecognizer:tap];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    [faceView addGestureRecognizer:pinch];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] init];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [swipe addTarget:self action:@selector(makeHappier)];
    [faceView addGestureRecognizer:swipe];
    
    swipe = [[UISwipeGestureRecognizer alloc] init];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [swipe addTarget:self action:@selector(makeSadder)];
    [faceView addGestureRecognizer:swipe];
}

- (void)onTap {
    self.faceView.eyesOpen = !self.faceView.eyesOpen;
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)pinch {
    switch (pinch.state) {
        case UIGestureRecognizerStateChanged:
            self.faceView.multiplier = pinch.scale;
            break;
        default:
            break;
    }
}

- (void)makeHappier {
    self.faceView.mouthLevel += 0.2;
}

- (void)makeSadder {
    self.faceView.mouthLevel -= 0.2;
}

@end
