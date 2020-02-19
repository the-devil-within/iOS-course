//
//  ViewController.m
//  MyCalc
//
//  Created by Blinov on 14.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "CalcBrain.h"
#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UILabel *displayLabel;
@property (nonatomic, assign, getter=isInTextInputMode) BOOL inTextInputMode;
@property (nonatomic, strong) CalcBrain *brain;

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self clear];

}

- (IBAction)buttonWithDigitDidTap:(UIButton *)button {
    NSString *digit = button.titleLabel.text;
    if (self.isInTextInputMode) {
        self.displayLabel.text = [self.displayLabel.text stringByAppendingString:digit];
    } else {
        self.inTextInputMode = YES;
        self.displayLabel.text = digit;
    }
}

- (IBAction)buttonWithOperationDidTap:(UIButton *)button {
    NSString *operator = button.titleLabel.text;
    self.brain.operator = operator;
    self.brain.waitingOperand = [self displayValue];
    
    //self.displayLabel.text = @"0";
    self.inTextInputMode = NO;
}

- (IBAction)performOperationButtonDidTap:(UIButton *)button {
    self.brain.operand = [self displayValue];
    double result = [self.brain performBinaryOperation];
    [self setResult:result];
}

- (CalcBrain *)brain {
    if (!_brain) {
        _brain = [[CalcBrain alloc] init];
    }
    return _brain;
}

- (double)displayValue {
    return self.displayLabel.text.doubleValue;
}

- (void)clear {
    //do smth here
}

- (void)setResult:(double)result {
    self.displayLabel.text = [NSString stringWithFormat:@"%g", result];
    self.inTextInputMode = NO;
}

@end
