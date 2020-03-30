//
//  QueryService.h
//  NetworkingExample
//
//  Created by Blinov on 30.03.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Track;

typedef void (^QueryResult) (NSArray <Track *> *, NSString *);

@interface QueryService : NSObject
- (void)getSearchResultsWithQuery:(NSString *)query completion:(QueryResult)completion;
@end
