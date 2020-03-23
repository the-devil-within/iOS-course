//
//  ViewController.m
//  FaceApp
//
//  Created by Blinov on 28.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "FaceViewController.h"
#import "FaceView.h"
#import "FaceModel.h"


@interface FaceViewController ()
@property (weak, nonatomic) IBOutlet FaceView *faceView;
@property (copy, nonatomic) NSDictionary *mapping;
@end

@implementation FaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (NSDictionary *)mapping {
    if (_mapping == nil) {
        _mapping = @{ @(MouthStateNeutral) : @0,
                      @(MouthStateFrown) : @(-1),
                      @(MouthStateSmile) : @1
        };
    }
    return _mapping;
}

- (void)setModel:(FaceModel *)model {
    _model = model;
    [self updateUI];
}

- (void)updateUI {
    self.faceView.eyesOpen = self.model.eyesOpen;
    NSNumber *mouthLevel = @(self.model.mouthState);
    self.faceView.mouthLevel = [self.mapping[mouthLevel] floatValue];
}

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
