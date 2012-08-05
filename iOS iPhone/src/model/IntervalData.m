//
//  IntervalData.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "IntervalData.h"
#import "AudioOutputCameraController.h"
#import "IntervalDuration.h"
#import "Interval.h"
#import "Shutter.h"
#import "ICameraController.h"

static IntervalData *_globalInstance = nil;

@implementation IntervalData

@synthesize interval = _interval;
@synthesize duration = _duration;
@synthesize shutter = _shutter;
@synthesize cameraController = _cameraController;

- (id)init {
    _shutter = [Shutter new];
    _interval = [Interval new];
    _duration = [IntervalDuration new];
    _cameraController = [AudioOutputCameraController new];
    
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
        _globalInstance = [[self alloc] init];
        initialized = YES;
        NSLog(@"init");
    }
        else {
            NSLog(@"return object");
        }
	
	return  _globalInstance;
}

- (void) dealloc {
	_globalInstance = nil;
}


@end


