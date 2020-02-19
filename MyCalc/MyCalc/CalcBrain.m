//
//  CalcBrain.m
//  MyCalc
//
//  Created by Blinov on 14.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "CalcBrain.h"

@implementation CalcBrain

- (void)clear {
    //do smth here
}

- (double)performOperation {
    double result = 0;
    //do smth here
    return result;
}

- (double)performBinaryOperation {
    double result = 0;
    if ([self.operator isEqualToString:@"+"]) {
        result = self.waitingOperand + self.operand;
    } else if ([self.operator isEqualToString:@"-"]) {
        result = self.waitingOperand - self.operand;
    } else if ([self.operator isEqualToString:@"*"]) {
        result = self.waitingOperand * self.operand;
    } else if ([self.operator isEqualToString:@"/"]) {
        if (self.operand != 0) {
            result = self.waitingOperand / self.operand;
        }
    }
    
    return result;
}

@end
