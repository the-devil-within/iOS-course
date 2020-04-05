//
//  PersonItem.m
//  PhoneBook
//
//  Created by Blinov on 04.04.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "PersonItem.h"

@implementation PersonItem

+ (instancetype)itemWithFirstName:(NSString *)name lastName:(NSString *)lastName phoneNumber:(NSString *)phone gender:(Gender)gender birthday:(NSDate *)bDay {
    return [[self alloc] initWithFirstName:name lastName:lastName phoneNumber:phone gender:gender birthday:bDay];
}

- (instancetype)initWithFirstName:(NSString *)name lastName:(NSString *)lastName phoneNumber:(NSString *)phone gender:(Gender)gender birthday:(NSDate *)bDay {
    self = [super init];
    if (self) {
        self.firstName = name;
        self.lastName = lastName;
        self.phoneNumber = phone;
        self.gender = gender;
        self.birthday = bDay;
    }
    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"\n<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"\n    firstName = %@\n    lastName = %@\n    phoneNumber = %@\n    gender = %ld\n    birthday = %@", self.firstName, self.lastName, self.phoneNumber, (long)self.gender, self.birthday];
    [description appendString:@"\n>\n"];
    return description;
}


@end
