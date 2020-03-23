//
//  EmotionsViewController.m
//  FaceApp
//
//  Created by Blinov on 23.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "EmotionsViewController.h"
#import "FaceViewController.h"
#import "FaceModel.h"

@interface EmotionsViewController ()
@property (nonatomic, copy) NSDictionary *mapping;
@end

@implementation EmotionsViewController

- (IBAction)chooseEmotion:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Выберите эмоцию" message:@"Каким будет наш смайлик?" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Счастливый" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self performSegueWithIdentifier:@"Happy" sender:sender];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Нейтральный" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self performSegueWithIdentifier:@"Neutral" sender:sender];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Грустный" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self performSegueWithIdentifier:@"Sad" sender:sender];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSDictionary *)mapping {
    if (!_mapping) {
        _mapping = @{ @"Sad" : [[FaceModel alloc] initWithEyes:NO mouthState:MouthStateFrown],
                      @"Happy" : [[FaceModel alloc] initWithEyes:NO mouthState:MouthStateSmile],
                      @"Neutral" : [[FaceModel alloc] initWithEyes:YES mouthState:MouthStateNeutral],
        };
    }
    return _mapping;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender {
    NSString *identifier = segue.identifier;
    FaceViewController *vc = segue.destinationViewController;
    FaceModel *model = self.mapping[identifier];
    vc.model = model;
    NSString *title = sender.currentTitle;
    vc.navigationItem.title = title;
}

@end
