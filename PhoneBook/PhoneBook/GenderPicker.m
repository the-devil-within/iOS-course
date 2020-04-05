//
//  GenderPicker.m
//  PhoneBook
//
//  Created by Blinov on 04.04.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "GenderPicker.h"

@implementation GenderPicker

-(void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
    self.dataSource = self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self titleForRow:row];
}

- (NSString *)titleForRow:(NSInteger)row {
    switch (row) {
        case 0:
            return @"---";
        case 1:
            return @"Male";
        case 2:
            return @"Female";
        default:
            NSAssert(NO, @"Smth wrong with amount of rows");
            return nil;
    }
}

- (Gender)selectedGender {
    switch ([self selectedRowInComponent:0]) {
        case 0:
            return GenderNotSelected;
        case 1:
            return GenderMale;
        case 2:
            return GenderFemale;
        default:
            NSAssert(NO, @"Smth wrong with amount of rows");
            return GenderNotSelected;
    }
}

@end
