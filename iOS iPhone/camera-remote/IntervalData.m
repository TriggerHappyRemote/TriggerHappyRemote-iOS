//
//  IntervalData.m
//  Trigger Happy, V1.0  
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "IntervalData.h"
#import "AudioOutputCameraController.h"


@implementation IntervalData

@synthesize interval = _interval;
@synthesize duration = _duration;
@synthesize shutter = _shutter;
@synthesize cameraController = _cameraController;
@synthesize cameraContollerMode = _cameraContollerMode;


- (id)init {
    
    _shutter = [Shutter new];
    _interval = [Interval new];
    _duration = [IntervalDuration new];
    _cameraContollerMode = AUDIO_CAMERA_CONTOLLER;
    _cameraController = [AudioOutputCameraController new];
    
    [[self.duration time] setTotalTimeInSeconds:3600];
    [[self.interval time] setTotalTimeInSeconds:6];
    [[[self.shutter bramper] startShutterLength] setTotalTimeInSeconds:1];
    [[[self.shutter bramper] endShutterLength] setTotalTimeInSeconds:5];
    [[self.shutter startLength] setTotalTimeInSeconds:1];

    return self;
}

@end


