//
//  CalcBrain.h
//  MyCalc
//
//  Created by Blinov on 14.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalcBrain : NSObject

@property (nonatomic, assign) double operand;
@property (nonatomic, assign) double waitingOperand;
@property (nonatomic, copy) NSString *operator;


- (double)performOperation;
- (double)performBinaryOperation;
- (void)clear;

@end
