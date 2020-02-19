//
//  CalcButton.m
//  MyCalc
//
//  Created by Blinov on 14.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "CalcButton.h"

@implementation CalcButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
    self.layer.borderWidth = 0.5;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.bounds.size.height/2;
}

@end
