//
//  ApplicationObserver.h
//  InputSourceChecker
//
//  Created by Nicolas Santangelo on 8/8/14.
//  Copyright (c) 2014 Nicolas Santangelo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InputSource.h"

@interface ApplicationObserver : NSObject

+ (id) start;

- (id) startWatching;

@end