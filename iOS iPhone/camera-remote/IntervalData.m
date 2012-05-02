//
//  IntervalData.m
//  Trigger Happy, V1.0  
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "IntervalData.h"

@implementation IntervalData

@synthesize interval = _interval;
@synthesize duration = _duration;
@synthesize shutter = _shutter;
@synthesize audioOutput = _audioOutput;


- (id)init {
    
    _shutter = [Shutter new];
    _interval = [Interval new];
    _duration = [IntervalDuration new];
    _audioOutput = [AudioOutputController new];
    
    [[self.duration time] setTotalTimeInSeconds:3600];
    [[self.interval time] setTotalTimeInSeconds:3];
    [[self.shutter startLength] setTotalTimeInSeconds:1];

    return self;
}

@end


