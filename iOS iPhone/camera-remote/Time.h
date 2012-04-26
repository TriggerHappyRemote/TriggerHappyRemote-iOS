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

//- (void) setTime: hours:(int)_hours minutes:(int)_minutes seconds:(int)_seconds;

/**
 * @return NSString is format on @"hh:mm"
 */
- (NSString *) toStringDownToMinutes;

/**
 * @return NSString is format on @"hh:mm:ss"
 */
- (NSString *) toStringDownToSeconds;

- (void) decrementSecond;






@end 
