//
//  AddPersonViewController.m
//  PhoneBook
//
//  Created by Blinov on 04.04.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "AddPersonViewController.h"
#import "PersonProtocols.h"
#import "PersonItem.h"
#import "GenderPicker.h"
#import "DBDataProvider.h"

@interface AddPersonViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet GenderPicker *genderPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *birthPicker;
@property (weak, nonatomic) IBOutlet UIButton *addButton;


@property (weak, nonatomic) PersonItem *person;
@property (strong, nonatomic) id<PersonUpdater> dataProvider;

@end

@implementation AddPersonViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _dataProvider = [DBDataProvider new];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.birthPicker.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.birthPicker.layer.borderWidth = 0.5;
    self.birthPicker.layer.cornerRadius = 4;
    self.genderPicker.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.genderPicker.layer.borderWidth = 0.5;
    self.genderPicker.layer.cornerRadius = 4;

}

- (IBAction)saveButtonDidTap:(UIButton *)button {
    [self performUpdateDB];
}

-(void)performUpdateDB {
    if (!self.person) {
        return;
    }
    if([self.dataProvider checkEntityExistenceWith:self.person]) {
        [self showAlertWithTitle:nil text:@"Entity already exists"];
        return;
    }
    [self.dataProvider insertEntityWith:self.person];
}

- (PersonItem *)person {
    return [self collectPersonData];
}

- (PersonItem *)collectPersonData {
    NSString *firstName = self.firstNameField.text;
    NSString *lastName = self.lastNameField.text;
    NSString *phone = self.phoneField.text;
    NSDate *birthday = self.birthPicker.date;
    Gender gender = [self.genderPicker selectedGender];
    
    
    NSMutableString *message = [NSMutableString stringWithString:@""];
    if ([firstName isEqualToString:@""]) {
       [message appendString:@"First name is empty.\n"];
    }
    if ([lastName isEqualToString:@""]) {
        [message appendString:@"Last name field is empty.\n"];
    }
    if ([phone isEqualToString:@""]) {
        [message appendString:@"Phone field is empty.\n"];
    }
    
    if (![[message copy] isEqualToString:@""]) {
        [self showAlertWithTitle:@"Empty parameter error" text:message];
        return nil;
    }
    
    return [[PersonItem alloc] initWithFirstName:firstName lastName:lastName phoneNumber:phone gender:gender birthday:birthday];
}

- (void)showAlertWithTitle:(NSString *)title text:(NSString *)text {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
