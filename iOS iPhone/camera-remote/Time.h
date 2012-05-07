//
//  Time.h
//  camera-remote
//
//  Created by Kevin Harrington on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Time : NSObject

@property (nonatomic) NSTimeInterval totalTimeInSeconds;
@property (nonatomic) int hours;
@property (nonatomic) int minutes;
@property (nonatomic) int seconds;
@property (nonatomic) int milliseconds;

/**
 * @return NSString is format of @"hh:mm"
 */
- (NSString *) toStringDownToMinutes;

/**
 * @return NSString is format of @"hh:mm:ss"
 */
- (NSString *) toStringDownToSeconds;

/**
 * @return NSString is format of @"mm:ss:ms"
 */
- (NSString *) toStringDownToMilliseconds;

- (void) decrementSecond;




@end 
