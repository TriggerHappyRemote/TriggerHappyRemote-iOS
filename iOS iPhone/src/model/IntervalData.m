//
//  IntervalData.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "IntervalData.h"
#import "IntervalDuration.h"
#import "Interval.h"
#import "Shutter.h"

static IntervalData *_singleShotInstance = nil;
static IntervalData *_timeLapseInstance = nil;
static BOOL timeLapseInstance = YES;

@implementation IntervalData

@synthesize interval = _interval;
@synthesize duration = _duration;
@synthesize shutter = _shutter;

- (id)init {
    _shutter = [Shutter new];
    _interval = [Interval new];
    _duration = [IntervalDuration new];
    
    [[self.duration time] setTotalTimeInSeconds:3600];
    [[self.interval time] setTotalTimeInSeconds:6];
    [[[self.shutter bramper] startShutterLength] setTotalTimeInSeconds:1];
    [[[self.shutter bramper] endShutterLength] setTotalTimeInSeconds:5];
    [[self.shutter startLength] setTotalTimeInSeconds:1];

    return self;
}

+ (IntervalData *)getInstance {
    static bool initialized = NO;
    if (!initialized) {
        _timeLapseInstance = [[self alloc] init];
        _singleShotInstance = [[self alloc] init];
        initialized = YES;
    }
    if(timeLapseInstance)
        return _timeLapseInstance;
    return _singleShotInstance;
}

+ (void) switchInstance:(BOOL)__timeLapseInstance {
    timeLapseInstance = __timeLapseInstance;
}

- (void) dealloc {
    _timeLapseInstance = nil;
	_singleShotInstance = nil;
}

- (void) constrainForTimeLapse {
    /*
    // shutter < interval
    if([self.shutter getMaxTime].totalTimeInSeconds >= self.interval.time.totalTimeInSeconds) {
        self.shutter.startLength.totalTimeInSeconds = self.interval.time.totalTimeInSeconds - .050;
        self.shutter.bramper.startShutterLength.totalTimeInSeconds  = self.shutter.startLength.totalTimeInSeconds;
        self.shutter.bramper.endShutterLength.totalTimeInSeconds  = self.shutter.startLength.totalTimeInSeconds;
        // HDR TODO
        
    }
    
    // interval < duration 
    if(self.interval.time.totalTimeInSeconds >= self.duration.time.totalTimeInSeconds) {
        self.interval.time.totalTimeInSeconds = self.duration.time.totalTimeInSeconds - 60;
    }
    // TODO: finish*/
    
    // bottom up
    NSTimeInterval maxShutter = [self.shutter.hdr getMaxShutterLength];
    if(maxShutter >= self.interval.time.totalTimeInSeconds) {
        self.interval.time.totalTimeInSeconds = maxShutter + 1;
        
        if(self.duration.time.totalTimeInSeconds <= self.interval.time.totalTimeInSeconds) {
            self.duration.time.totalTimeInSeconds = self.interval.time.totalTimeInSeconds + 60;
        }
    }
}

@end


