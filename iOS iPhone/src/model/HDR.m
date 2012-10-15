//
//  HDR.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "HDR.h"
#import "IntervalData.h"
#import "Interval.h"

@implementation HDR

@synthesize numberOfShots = _numberOfShots;
@synthesize baseShutterSpeed = _baseShutterSpeed;
@synthesize bulb = _bulb;
@synthesize evInterval = _evInterval;
@synthesize pickerMode;
@synthesize shutterGap;

-(id) init {
    _numberOfShots = 3;
    _baseShutterSpeed = [Time new];
    _bulb = true;
    _evInterval = .333;
    self.shutterGap = .33;
    [_baseShutterSpeed setTotalTimeInSeconds:1];
    return self;
}

-(NSString*) getButtonData {
    if(self.bulb) {
        return [self.baseShutterSpeed toStringDownToSeconds];
    } else {
        return [[NSString alloc] initWithFormat:@"Auto"];
    }
}

-(NSTimeInterval) getMaxShutterLength {
    NSTimeInterval totalTime = 0.0;
    NSArray *times = [self getShutterLengths];
    for(Time *t in times) {
        totalTime += t.totalTimeInSeconds + shutterGap;
    }
    return totalTime;
}

- (NSMutableArray *) getShutterLengths {
    NSMutableArray *times = [NSMutableArray array];
    [times addObject:self.baseShutterSpeed];
    for(int i = 0; i < (int)(self.numberOfShots / 2); i++) {
        [times addObject:[[Time alloc] initWithTotalTimeInSeconds: [self.baseShutterSpeed totalTimeInSeconds] * pow (2, self.evInterval * (i+1))]];
        [times addObject:[[Time alloc] initWithTotalTimeInSeconds:[self.baseShutterSpeed totalTimeInSeconds] * pow (2, -1 * self.evInterval * (i+1))]];
    }
    
    return times;
}

- (NSTimeInterval) maxTimeBetweenShots {
    NSTimeInterval totalTimeShutterIsOpen = [self getMaxShutterLength] - shutterGap * self.numberOfShots;
    NSTimeInterval leftoverTime = [IntervalData getInstance].interval.time.totalTimeInSeconds - totalTimeShutterIsOpen;
    return leftoverTime / self.numberOfShots - TIMING_THREASHOLD;
}

@end
