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
@synthesize shutterGap = _shutterGap;

-(id) init {
    _numberOfShots = 3;
    _baseShutterSpeed = [Time new];
    _bulb = true;
    _evInterval = .333;
    _shutterGap = .333;
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

-(NSTimeInterval) getMaxShutterLength {

    
    NSTimeInterval totalTime = [self.baseShutterSpeed totalTimeInSeconds];
    for(int i = 0; i < (int)(self.numberOfShots / 2); i++) {
        totalTime += [self.baseShutterSpeed totalTimeInSeconds] * pow (2, self.evInterval * i);
        totalTime += [self.baseShutterSpeed totalTimeInSeconds] * pow (2, -1 * self.evInterval * i);

    }
    
    totalTime += self.shutterGap * self.numberOfShots;

    NSLog(@"Total time: %f", totalTime);
    return totalTime;
}

- (NSMutableArray *) getShutterLengths {
    NSMutableArray * times = [[NSMutableArray alloc] init];
    [times addObject:self.baseShutterSpeed];
    for(int i = 0; i < (int)(self.numberOfShots / 2); i++) {
        [times addObject:[[Time alloc] initWithTotalTimeInSeconds: [self.baseShutterSpeed totalTimeInSeconds] * pow (2, self.evInterval * i)]];
        [times addObject:[[Time alloc] initWithTotalTimeInSeconds:[self.baseShutterSpeed totalTimeInSeconds] * pow (2, -1 * self.evInterval * i)]];
    }
    return times;
}


@end
