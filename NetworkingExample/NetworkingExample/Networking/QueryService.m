//
//  QueryService.m
//  NetworkingExample
//
//  Created by Blinov on 30.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "QueryService.h"
#import "Track.h"

typedef NSDictionary <NSString *, id> * JSONDictionary;

@interface QueryService()
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, strong) NSMutableArray <Track *> *tracks;
@property (nonatomic, strong) NSURLSession *defaultSession;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@end

@implementation QueryService

- (void)getSearchResultsWithQuery:(NSString *)query completion:(QueryResult)completion {
    [self.dataTask cancel];

    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:@"https://itunes.apple.com/search"];
    urlComponents.query = [NSString stringWithFormat:@"media=music&entity=song&term=%@", query];
    
    NSURL *url = urlComponents.URL;
    if (!url) {
        return;
    }
    
    __weak QueryService *welf = self;
    self.dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            welf.errorMessage = [self.errorMessage stringByAppendingString:@"DataTask error: \(error.localizedDescription)\n"];
            welf.dataTask = nil;
            completion(self.tracks, self.errorMessage);
            return;
        }
        
        if (data == nil) {
            completion(self.tracks, self.errorMessage);
            welf.dataTask = nil;
            return;
        }
    
        NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
        if (resp != nil && resp.statusCode == 200) {
            welf.dataTask = nil;
            [welf updateSearchResultsWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(self.tracks, self.errorMessage);
            });
        }
    }];
    
    [self.dataTask resume];
}

#pragma mark - Private

- (void)updateSearchResultsWithData:(NSData *)data {
    JSONDictionary response = @{};
    self.tracks = [NSMutableArray new];
    NSError *error = nil;
    @try {
        response = (JSONDictionary)[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    } @catch (NSError *parseError) {
        self.errorMessage = [self.errorMessage stringByAppendingString:@"JSONSerialization error: \(parseError.localizedDescription)\n"];
        return;
    } @finally { }
    
    NSArray *array = response[@"results"];
    if (!array) {
        self.errorMessage = [self.errorMessage stringByAppendingString:@"Dictionary does not contain results key\n"];
    }
    
    int index = 0;
    
    for (NSDictionary *trackDictionary in array) {
        NSString *previewURLString = trackDictionary[@"previewUrl"];
        NSURL *previewURL = [NSURL URLWithString:previewURLString];
        NSString *name = trackDictionary[@"trackName"];
        NSString *artist = trackDictionary[@"artistName"];
        if (!previewURLString && !previewURL && !name && !artist) {
            self.errorMessage = [self.errorMessage stringByAppendingString:@"Problem parsing trackDictionary\n"];
            return;
        }
        Track *track = [[Track alloc] initWithName:name artist:artist previewURL:previewURL index:index];
        [self.tracks addObject:track];
        index++;
    }
}

- (NSURLSession *)defaultSession {
    if (!_defaultSession) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _defaultSession = [NSURLSession sessionWithConfiguration:config];
    }
    return _defaultSession;
}
@end
