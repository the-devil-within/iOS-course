//
//  Track.h
//  NetworkingExample
//
//  Created by Blinov on 30.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject
@property (nonatomic, readonly, copy) NSString *artist;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, assign) int index;
@property (nonatomic, readonly, strong) NSURL *previewURL;

@property (nonatomic, assign) BOOL downloaded;


- (instancetype)initWithName:(NSString *)name artist:(NSString *)artist previewURL:(NSURL *)previewURL index:(int)index;
@end

