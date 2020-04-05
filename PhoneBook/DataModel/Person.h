//
//  Person+CoreDataClass.h
//  PhoneBook
//
//  Created by Blinov on 04.04.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface PersonManagedObject : NSManagedObject
@property (nullable, nonatomic, copy) NSString *first_name;
@property (nullable, nonatomic, copy) NSString *last_name;
@property (nonatomic) int16_t gender;
@property (nullable, nonatomic, copy) NSDate *birthday;
@property (nullable, nonatomic, copy) NSString *phone_number;
@end
