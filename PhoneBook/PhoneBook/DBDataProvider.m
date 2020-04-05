//
//  DBDataProvider.m
//  PhoneBook
//
//  Created by Blinov on 04.04.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "DBDataProvider.h"
#import "PersonManagedObject+Insert.h"
#import "Person.h"
#import "PersonItem.h"

#import <CoreData/CoreData.h>

@interface DBDataProvider()
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation DBDataProvider

#pragma mark - PersonUpdater, PersonProvider

- (BOOL)checkEntityExistenceWith:(PersonItem *)item {
    NSArray<PersonManagedObject *> *matches = [self fetchResultsForItem:item];
    BOOL hasError = matches == nil || (matches.count > 1); //we should get only 1 entity
    BOOL isEmpty = matches.count == 0;
    return !hasError && !isEmpty;
}

- (void)deleteEntityWith:(PersonItem *)item {
    NSError *error;
    NSArray<PersonManagedObject *> *matches = [self fetchResultsForItem:item];
    [self.managedObjectContext deleteObject:[matches firstObject]];
    [self.managedObjectContext save:&error];
}

- (void)insertEntityWith:(PersonItem *)item {
    [PersonManagedObject insertPerson:item inManagedObjectContext:self.managedObjectContext];
}

- (void)getPersonListWithCompletion:(void (^)(NSArray *))completion {
    NSFetchRequest *fetchRequest = [self createFetchRequestWithPredicate:nil sortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"first_name" ascending:YES]]];
    NSError *error;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *content = [[NSMutableArray alloc] init];
    for (PersonManagedObject *person in fetchedObjects) {
        [content addObject:[PersonManagedObject personItemWithPerson:person]];
    }
    completion(content);
}

#pragma mark - CoreData stack

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = coordinator;
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Copy the default store (with a pre-populated data) into our Documents folder.
    NSString *documentsStorePath = [[self applicationDocumentsDirectory].path stringByAppendingPathComponent:@"PhoneBook.sqlite"];
    
    // if the expected store doesn't exist, copy the default store
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsStorePath]) {
        NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"PhoneBook" ofType:@"sqlite"];
        if (defaultStorePath) {
            [[NSFileManager defaultManager] copyItemAtPath:defaultStorePath toPath:documentsStorePath error:NULL];
        }
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    // Add the default store to our coordinator.
    NSError *error;
    NSURL *defaultStoreURL = [NSURL fileURLWithPath:documentsStorePath];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:defaultStoreURL
                                                         options:nil
                                                           error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible
         * The schema for the persistent store is incompatible with current managed object model
         Check the error message to determine what the actual problem was.
         */
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
    }
    return _persistentStoreCoordinator;
}

#pragma mark - Private

- (NSArray<PersonManagedObject *> *)fetchResultsForItem:(PersonItem *)item {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"phone_number = %@", item.phoneNumber];
    NSFetchRequest *fetchRequest = [self createFetchRequestWithPredicate:predicate sortDescriptors:nil];

    NSError *error;
    NSArray<PersonManagedObject *> *matches = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return matches;
}

- (NSFetchRequest *)createFetchRequestWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray<NSSortDescriptor*> *)sortDescriptors {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.predicate = predicate;
    fetchRequest.sortDescriptors = sortDescriptors;
    return fetchRequest;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
}

@end
