//
//  DBDataProvider.h
//  PhoneBook
//
//  Created by Blinov on 04.04.2020.
//  Copyright © 2020 Evgeny Blinov. All rights reserved.
//

#import "PersonProtocols.h"
#import <Foundation/Foundation.h>

@interface DBDataProvider : NSObject <PersonUpdater, PersonProvider>

@end
