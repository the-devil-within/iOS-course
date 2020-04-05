//
//  PersonUpdater.h
//  PhoneBook
//
//  Created by Blinov on 04.04.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PersonItem;

@protocol PersonUpdater <NSObject>

-(void)insertEntityWith:(PersonItem *)item;
-(void)deleteEntityWith:(PersonItem *)item;
-(BOOL)checkEntityExistenceWith:(PersonItem *)item;

@end

@protocol PersonProvider <NSObject>

- (void)getPersonListWithCompletion:(void (^)(NSArray *))completion;

@end
