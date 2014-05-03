//
//  HDR.m
//  Copyright (c) 2014 Kevin Harrington
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  Created by Kevin Harrington on 1/9/12.
//  
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
