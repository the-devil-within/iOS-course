//
//  GenderPicker.h
//  PhoneBook
//
//  Created by Blinov on 04.04.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Gender) {
    GenderNotSelected = -1,
    
    GenderMale = 0,
    GenderFemale
};

@interface GenderPicker : UIPickerView <UIPickerViewDelegate, UIPickerViewDataSource>
- (Gender)selectedGender;
@end
