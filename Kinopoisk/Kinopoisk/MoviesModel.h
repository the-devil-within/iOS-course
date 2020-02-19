//
//  MoviesModel.h
//  Kinopoisk
//
//  Created by Blinov on 17.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MovieItem;

@interface MoviesModel : NSObject

- (MovieItem *)movieAtIndex:(NSInteger)index;
- (NSUInteger)moviesCount;

@end
