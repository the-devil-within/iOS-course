//
//  QueryService.m
//  NetworkingExample
//
//  Created by Blinov on 30.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "QueryService.h"
#import "Track.h"

typedef NSDictionary <NSString *, id>* JSONDictionary;

@interface QueryService()
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, strong) NSMutableArray <Track *> *tracks;
@end


@implementation QueryService
- (void)getSearchResultsWithQuery:(NSString *)query completion:(QueryResult)completion {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        completion(self.tracks, self.errorMessage);
    });

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
        }
        Track *track = [[Track alloc] initWithName:name artist:artist previewURL:previewURL index:index];
        [self.tracks addObject:track];
        index++;

    }
    
}
@end
