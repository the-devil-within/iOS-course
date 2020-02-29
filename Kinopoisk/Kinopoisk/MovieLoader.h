//
//  MovieLoader.h
//  Kinopoisk
//
//  Created by Blinov on 17.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MovieItem;
typedef void (^MoviesBlock)(NSArray <MovieItem *> *);

@interface MovieLoader : NSObject
- (void)loadMoviesWithCompletion:(MoviesBlock)completion;
@end
