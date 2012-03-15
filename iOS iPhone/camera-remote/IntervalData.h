//
//  IntervalData.h
//  camera-remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntervalometerCountDownViewController.h"

@interface IntervalData : NSObject {
    NSTimeInterval duration;
    NSTimeInterval interval;
    NSTimeInterval shutterSpeed;
    
    
    int intervalHours;
    int intervalSeconds;
    int intervalMinutes;
    
    int shutterHours;
    int shutterSeconds;
    int shutterMinutes;
}

- (NSTimeInterval) getDuration;

- (NSTimeInterval) getShutterSpeed;

- (NSString *) getDurationStringParsedForCountDown;

- (NSString *) getIntervalStringParsed;

- (NSString *) getShutterStringParsed;

- (NSString *) getDurationStringParsed;

- (NSString *) getDurationStringParsed2;

- (NSString *) getCountDownTimeStringParsed;

// ---------------------------------------------------------
// Interval
// ---------------------------------------------------------

- (int) getShutterSeconds;

- (int) getShutterMinutes;

- (int) getShutterHours;

- (NSTimeInterval) getShutterInSeconds;

-(void) setShutterHours: (int) hours;

-(void) setShutterMinutes: (int) minutes;

-(void) setShutterSeconds: (int) seconds;

// ---------------------------------------------------------
// Duration
// ---------------------------------------------------------

- (int) getIntervalSeconds;

- (int) getIntervalMinutes;

- (int) getIntervalHours;

- (NSTimeInterval) getIntervalInSeconds;

-(void) setIntervalHours: (int) hours;

-(void) setIntervalMinutes: (int) minutes;

-(void) setIntervalSeconds: (int) seconds;

// ---------------------------------------------------------


- (void) setDuration:(NSTimeInterval) dur;

- (bool) isUnlimitedDuration;

- (void) setUnlimitedDuration: (bool) unlimit;

- (bool) isAutoShutter;

- (void) setAutoShutter: (bool) unlimit;

// --------------------------------------------------------
// HDR

- (bool) isThirdStop;

- (void) toggleThirdStop;

- (void) setNumberOfShots : (int) _numberOfShots;

- (int) getNumberOfShots;

- (void) setEV : (int) _EV;

- (int) getEV;

@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSTimeInterval interval;
@property (nonatomic) NSTimeInterval shutterSpeed;
@property (nonatomic) bool unlimitedDuration;
@property (nonatomic) bool autoShutter;
@property (nonatomic) bool isThirdStop;


@property (nonatomic) int intervalHours;
@property (nonatomic) int intervalSeconds;
@property (nonatomic) int intervalMinutes;
@property (nonatomic) int shutterHours;
@property (nonatomic) int shutterSeconds;
@property (nonatomic) int shutterMinutes;

@property (nonatomic) int numberOfShots;

// base 3
@property (nonatomic) int exposureValue;



@end
