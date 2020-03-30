//
//  AppDelegate.h
//  NetworkingExample
//
//  Created by Blinov on 30.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^VoidBlock) (void);
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy) VoidBlock backgroundSessionCompletionHandler;


@end

