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
#import "LEGACYAudioOutputCameraController.h"

static IntervalData *_globalInstance = nil;

@interface IntervalData ()
@property (nonatomic, retain) ICameraController *controller_new;
@property (nonatomic, retain) ICameraController *controller_old;
@end

@implementation IntervalData

@synthesize interval = _interval;
@synthesize duration = _duration;
@synthesize shutter = _shutter;
@synthesize cameraController = _cameraController;

@synthesize controller_old, controller_new;

- (id)init {
    _shutter = [Shutter new];
    _interval = [Interval new];
    _duration = [IntervalDuration new];
    
    controller_new = [AudioOutputCameraController new];
    controller_old = [LEGACYAudioOutputCameraController new];
    _cameraController = controller_new;
    
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
    }
	return  _globalInstance;
}

- (void) dealloc {
	_globalInstance = nil;
}

- (void) assertTimingConstraints {
    NSAssert(self.interval.time.totalTimeInSeconds < self.duration.time.totalTimeInSeconds, @"Interval (%f) must be shorter than Duration(%f)", self.interval.time.totalTimeInSeconds, self.duration.time.totalTimeInSeconds);
    // TODO: finish
}

- (void) changeCameraControllerTo:(int)type {
    if(type == CAMERA_CONTROLLER_NEW) {
        _cameraController = self.controller_new;
    } else {
        _cameraController = self.controller_old;
    }
}

- (int) cameraControllerType {
    if([_cameraController class] == [AudioOutputCameraController class]) {
        return CAMERA_CONTROLLER_NEW;
    }
    return CAMERA_CONTROLLER_OLD;
}


@end


