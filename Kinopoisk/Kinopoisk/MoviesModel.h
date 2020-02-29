//
//  MoviesModel.h
//  Kinopoisk
//
//  Created by Blinov on 17.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^VoidBlock) (void);
@class MovieItem;

@interface MoviesModel : NSObject

- (void)loadMoviesWithCompletion:(VoidBlock)completion;

- (MovieItem *)movieAtIndex:(NSInteger)index;
- (NSUInteger)moviesCount;

@end
