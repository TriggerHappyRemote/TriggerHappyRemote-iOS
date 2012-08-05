//
//  Time.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

@interface Time : NSObject

@property (nonatomic) NSTimeInterval totalTimeInSeconds;
@property (nonatomic) int hours;
@property (nonatomic) int minutes;
@property (nonatomic) int seconds;
@property (nonatomic) int milliseconds;
@property (nonatomic) bool unlimited;

/**
 * constrcutor for totalTimeInSeconds
 */
-(Time *) initWithTotalTimeInSeconds:(NSTimeInterval) totalTime;

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

/**
 * @return NSString with format of @"XX hours XX minutes XX seconds XX milliseconds 
 */
- (NSString *) toStringDescriptive;


- (void) decrementSecond;

-(id) initUnlimited;

@end 
