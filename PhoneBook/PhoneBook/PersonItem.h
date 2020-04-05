//
//  PersonItem.h
//  PhoneBook
//
//  Created by Blinov on 04.04.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenderPicker.h"

@interface PersonItem : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, assign) Gender gender;
@property (nonatomic, copy) NSDate *birthday;

- (instancetype)initWithFirstName:(NSString *)name lastName:(NSString *)lastName phoneNumber:(NSString *)phone gender:(Gender)gender birthday:(NSDate *)bDay;
+ (instancetype)itemWithFirstName:(NSString *)name lastName:(NSString *)lastName phoneNumber:(NSString *)phone gender:(Gender)gender birthday:(NSDate *)bDay;

@end
