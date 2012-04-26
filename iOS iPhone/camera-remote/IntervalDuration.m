//
//  IntervalDuration.m
//  Trigger Happy, V1.0
//
//  Created by Kevin Harrington on 4/26/12.
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
