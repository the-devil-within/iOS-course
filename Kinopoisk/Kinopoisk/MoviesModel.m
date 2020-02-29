//
//  MoviesModel.m
//  Kinopoisk
//
//  Created by Blinov on 17.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "MoviesModel.h"
#import "MovieLoader.h"
#import "MovieItem.h"

@interface MoviesModel()
@property (nonatomic, strong) NSArray<MovieItem *> *movies;
@property (nonatomic, strong) MovieLoader *loader;
@end

@implementation MoviesModel

- (void)loadMoviesWithCompletion:(VoidBlock)completion {
    __weak MoviesModel *weakSelf = self;
    [self.loader loadMoviesWithCompletion:^(NSArray<MovieItem *> *movies) {
        weakSelf.movies = movies;
        completion();
    }];
}

- (MovieItem *)movieAtIndex:(NSInteger)index {
    if (index > [self moviesCount]) {
        return nil;
    }
    return self.movies[index];
}

- (NSUInteger)moviesCount {
    return self.movies.count;
}

- (MovieLoader *)loader {
    if (!_loader) {
        _loader = [[MovieLoader alloc] init];
    }
    return _loader;
}

@end
