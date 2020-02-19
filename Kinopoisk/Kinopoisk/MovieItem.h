//
//  MovieItem.h
//  Kinopoisk
//
//  Created by Blinov on 17.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieItem : NSObject
@property (nonatomic, strong, readonly) NSString *movieTitle;
@property (nonatomic, strong, readonly) NSString *movieDescription;
@property (nonatomic, strong, readonly) NSString *imageName;
@property (nonatomic, strong, readonly) NSString *date;

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)description date:(NSString *)date imageName:(NSString *)imageName;
@end
