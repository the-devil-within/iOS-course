//
//  MovieLoader.m
//  Kinopoisk
//
//  Created by Blinov on 17.02.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "MovieLoader.h"
#import "MovieItem.h"
#import "MoviesJsonData.h"

static NSString *const kMovies = @"movies";

static NSString *const kTitle = @"title";
static NSString *const kDescription = @"description";
static NSString *const kDate = @"date";
static NSString *const kImageName = @"imageName";


@interface MovieLoader()
@property (nonatomic, strong) MoviesJsonData *moviesData;
@end

@implementation MovieLoader

- (void)loadMoviesWithCompletion:(MoviesBlock)completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion([self loadMovies]);
    });
}

- (NSArray <MovieItem *> *)loadMovies {
    NSArray *movies = [[NSArray alloc] init];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:self.moviesData.jsonData options:0 error:&error];
    
    if (error) {}
    
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *obj = jsonObject;
        NSArray *moviesDict = obj[kMovies];
        movies = [self parseMoviesFrom:moviesDict];
    }
    
    
    return movies;
}

- (NSArray <MovieItem *> *)parseMoviesFrom:(NSArray *)array {
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        MovieItem *movie = [[MovieItem alloc] initWithTitle:dict[kTitle] description:dict[kDescription] date:dict[kDate] imageName:dict[kImageName]];
        [movies addObject:movie];
    }
    
    return [movies copy];
}

- (MoviesJsonData *)moviesData {
    if (!_moviesData) {
        _moviesData = [MoviesJsonData new];
    }
    return _moviesData;
}

@end
