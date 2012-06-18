//
//  HDR.m
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "HDR.h"

@implementation HDR

@synthesize numberOfShots = _numberOfShots;
@synthesize baseShutterSpeed = _baseShutterSpeed;
@synthesize bulb = _bulb;
@synthesize evInterval = _evInterval;
@synthesize pickerMode;

-(id) init {
    _numberOfShots = 3;
    _baseShutterSpeed = [Time new];
    _bulb = true;
    _evInterval = 1;
    
    [_baseShutterSpeed setTotalTimeInSeconds:1];
    return self;
}

-(NSString*) getButtonData {
    if(self.bulb) {
        return [self.baseShutterSpeed toStringDownToSeconds];
    }
    else {
        return [[NSString alloc] initWithFormat:@"Auto"];
    }
}

-(Time*) getMaxShutterLength {
    // TODO
    return self.baseShutterSpeed;
}



@end
