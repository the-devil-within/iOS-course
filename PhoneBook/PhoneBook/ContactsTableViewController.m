//
//  ContactsTableViewController.m
//  PhoneBook
//
//  Created by Blinov on 04.04.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "PersonProtocols.h"
#import "PersonItem.h"
#import "DBDataProvider.h"

@interface ContactsTableViewController ()
@property (strong, nonatomic) id<PersonProvider> dataProvider;
@property (strong, nonatomic) NSArray<PersonItem *> *contactList;
@end

@implementation ContactsTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _dataProvider = [DBDataProvider new];
        _contactList = @[];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getContactList];
}

- (void)getContactList {
    __weak ContactsTableViewController * welf = self;
    [self.dataProvider getPersonListWithCompletion:^(NSArray *contacts) {
        welf.contactList = contacts;
        [welf.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contactList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell" forIndexPath:indexPath];
    PersonItem *item = self.contactList[indexPath.row];
    NSString *name = [NSString stringWithFormat:@"%@ %@", item.firstName, item.lastName];
    cell.textLabel.text = name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonItem *item = self.contactList[indexPath.row];
    NSLog(@"%@", [item description]);
}

@end
