//
//  Interval.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "Interval.h"

@implementation Interval

@synthesize time = _time;
@synthesize intervalEnabled = _intervalEnabled;

@synthesize pickerMode;

-(id) init {
    _time = [Time new];
    self.intervalEnabled = true;
    self.pickerMode = SECONDS; 
    return self;
}

-(NSString*) getButtonData {
    if(self.pickerMode == SECONDS) {
        return [self.time toStringDownToSeconds];
    }
    return [self.time toStringDownToMilliseconds];
}



@end
