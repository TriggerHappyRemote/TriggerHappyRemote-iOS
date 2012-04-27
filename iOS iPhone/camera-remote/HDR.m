//
//  HDR.m
//  camera-remote
//
//  Created by Kevin Harrington on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HDR.h"

@implementation HDR

@synthesize numberOfShots = _numberOfShots;
@synthesize baseShutterSpeed = _baseShutterSpeed;
@synthesize bulb = _bulb;
@synthesize evInterval = _evInterval;

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

@end
