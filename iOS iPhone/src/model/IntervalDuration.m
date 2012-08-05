//
//  IntervalDuration.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
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
