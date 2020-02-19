//
//  MovieItem.m
//  Kinopoisk
//
//  Created by Blinov on 17.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "MovieItem.h"

@interface MovieItem()
@property (nonatomic, strong, readwrite) NSString *movieTitle;
@property (nonatomic, strong, readwrite) NSString *movieDescription;
@property (nonatomic, strong, readwrite) NSString *imageName;
@property (nonatomic, strong, readwrite) NSString *date;
@end

@implementation MovieItem

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)description date:(NSString *)date imageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        _movieTitle = title;
        _movieDescription = description;
        _date = date;
        _imageName = imageName;
    }
    return self;
}

@end
