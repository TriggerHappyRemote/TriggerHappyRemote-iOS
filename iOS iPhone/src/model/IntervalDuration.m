//
//  IntervalDuration.m
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//
#import "IntervalDuration.h"

@implementation IntervalDuration

@synthesize time = _time;
@synthesize unlimitedDuration = _unlimitedDuration;

-(id) init {
    _time = [Time new];
    return self;
}

@end
