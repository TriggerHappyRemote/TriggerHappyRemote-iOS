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
@synthesize shutterSpeed = _shutterSpeed;

@synthesize mode = _mode;


- (id)init {
    _mode = STANDARD;
    
    //TODO: empcomass in own class
    _shutterSpeed = [Time new];

    _interval = [Interval new];
    _duration = [IntervalDuration new];
    
    
    [[self.duration time] setTotalTimeInSeconds:3600];
    [[self.interval time] setTotalTimeInSeconds:3];
    
    //self.shutterSpeed.totalTimeInSeconds = .01;
    //self.shutterSpeed.totalTimeInSeconds = 2;
    

    return self;
}

@end


