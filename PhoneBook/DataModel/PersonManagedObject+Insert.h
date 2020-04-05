//
//  PersonManagedObject+Insert.h
//  PhoneBook
//
//  Created by Blinov on 04.04.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "Person.h"
@class PersonItem;
@interface PersonManagedObject (Insert)
+ (void)insertPerson:(PersonItem *)item inManagedObjectContext:(NSManagedObjectContext *)context;
+ (PersonItem *)personItemWithPerson:(PersonManagedObject *)person;
@end
