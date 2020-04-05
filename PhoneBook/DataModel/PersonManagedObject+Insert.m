//
//  PersonManagedObject+Insert.m
//  PhoneBook
//
//  Created by Blinov on 04.04.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "PersonManagedObject+Insert.h"
#import "PersonItem.h"

@implementation PersonManagedObject (Insert)

+ (void)insertPerson:(PersonItem *)item inManagedObjectContext:(NSManagedObjectContext *)context {
    PersonManagedObject *person;
    NSError *error;
    person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                           inManagedObjectContext:context];
    person.first_name = item.firstName;
    person.birthday = item.birthday;
    person.gender = item.gender;
    person.last_name = item.lastName;
    person.phone_number = item.phoneNumber;
    [context save:&error];
    
}

+ (PersonItem *)personItemWithPerson:(PersonManagedObject *)person {
    return [PersonItem itemWithFirstName:person.first_name lastName:person.last_name phoneNumber:person.phone_number gender:person.gender birthday:person.birthday];
}

@end
