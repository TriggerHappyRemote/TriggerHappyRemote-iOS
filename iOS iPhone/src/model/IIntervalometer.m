//
//  IIntervalometer.m
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

#import "IIntervalometer.h"
#import "IntervalData.h"
#import "AppDelegate.h"
#import "Time.h"
#import "ICameraController.h"
#import "Shutter.h"
#import "Interval.h"
#import "IntervalDuration.h"
#import "HardwareManager.h"

@interface IIntervalometer()
    @property (nonatomic, strong) Time * remainingTime;
    - (void) intervalometerDurationInterrupt;
    - (void) intervalometerIntervalInterrupt;
    - (void) intervalometerSubInterrupt;
    - (void) startShutter;
    - (void) shutterInterrupt;
- (void) clearShuttersTimer;
@end

@implementation IIntervalometer

@synthesize remainingTime = _remainingTime;

IntervalometerCountDownViewController *intervalometerCountDownViewController;

NSTimer *durationTimer;
NSTimer *intervalTimer;
NSTimer *shuttersTimer;
NSTimer *shutterTimer;

ICameraController * cameraController;

int currentCountDownTimeSeconds;
//miliseconds - up to 24 hours
int currentCountDownTimeMS;
int currentShutterTimeMS;
float interruptIntervalMS;
int millisecondInterval;
float shutterLengthMS;
float brampingAlpha;

NSMutableArray * shutterTimes;

int hdrShutterIndex;


- (id) init {
    cameraController = [HardwareManager getInstance].cameraController;
    _remainingTime = [Time new];  
    shutterTimes = [[[IntervalData getInstance] shutter] getShutterLengths];
    hdrShutterIndex = 0;
    return self;
}

- (void) setIntervalometerCountdownViewControllerReference: (IntervalometerCountDownViewController *) _view {
    // reference made so we can make call backs to the view controller
    //  with updated time. 
    intervalometerCountDownViewController = _view;
}

- (void) startIntervalometer {
    // variables used to model sliders on the view controller
    interruptIntervalMS = .025;
    millisecondInterval = (int)(1000 * interruptIntervalMS);
    
    if([[[IntervalData getInstance] shutter] mode] == HDR_MODE) {
        shutterLengthMS = [[[[IntervalData getInstance] shutter] getMaxTime] totalTimeInSeconds] * 1000;
    }
    else {
        shutterLengthMS = [[[[IntervalData getInstance] shutter] currentLength] totalTimeInSeconds] * 1000;
    }
    currentShutterTimeMS = shutterLengthMS;
    
    
    
    
    if([[[IntervalData getInstance] shutter] mode] == BRAMP) {
        
        // DELTA = stop - start
        // NUM_INTERVALS = DURATION / Interval;
        // ALPHA = DELTA / NO_INTERVALS
        
        float delta = [[[[[IntervalData getInstance] shutter] bramper] endShutterLength] totalTimeInSeconds] - [[[[[IntervalData getInstance] shutter] bramper] startShutterLength] totalTimeInSeconds];
        
        
        float num_intervals = [[[[IntervalData getInstance] duration] time] totalTimeInSeconds] / [[[[IntervalData getInstance] interval] time] totalTimeInSeconds] - 1;
        brampingAlpha = delta / num_intervals;

        
    }
    else {
        brampingAlpha = 0.0;
    }
    
    [[[IntervalData getInstance] shutter] initializeCurrentLength];
    [[[IntervalData getInstance] shutter] currentLength].totalTimeInSeconds -= brampingAlpha;
    
    currentCountDownTimeMS = [[[[IntervalData getInstance] interval] time] totalTimeInSeconds] * 1000;
    
    if(![[[IntervalData getInstance] duration] unlimitedDuration] && [[[IntervalData getInstance] interval] intervalEnabled]) {
        
        currentCountDownTimeSeconds = [[[[IntervalData getInstance] duration] time] totalTimeInSeconds];
        [self.remainingTime setTotalTimeInSeconds:[[[[IntervalData getInstance] duration] time] totalTimeInSeconds]];
        
        durationTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                         target:self
                                                       selector:@selector(intervalometerDurationInterrupt)
                                                       userInfo:nil
                                                        repeats:YES];
    }
    
    if([[[IntervalData getInstance] interval] intervalEnabled]) {
        // interval timer is constant
        intervalTimer = [NSTimer scheduledTimerWithTimeInterval:interruptIntervalMS
                                                     target:self
                                                   selector:@selector(intervalometerSubInterrupt)
                                                   userInfo:nil
                                                    repeats:YES];

    }   
    
    // start the first shot when the camera fires
    [self intervalometerIntervalInterrupt];
     

}



- (void) intervalometerDurationInterrupt {
    currentCountDownTimeSeconds--;
    [self.remainingTime decrementSecond];
    
    if(currentCountDownTimeSeconds <= 0) {
        [self stopIntervalometer];
    }
    else {
        // to update clock on the view controller
        [intervalometerCountDownViewController notifyOfInterrupt:[self.remainingTime toStringDownToSeconds]];
    }
}

- (void) intervalometerSubInterrupt {
    currentCountDownTimeMS -= millisecondInterval;
    
    // if we hit an interval
    if(currentCountDownTimeMS <= 0) {
        currentCountDownTimeMS = [[[[IntervalData getInstance] interval] time] totalTimeInSeconds] * 1000;

        [self intervalometerIntervalInterrupt];
    }
    
    // not matter what we always update the slider to indicate the slider progress
    float progress = 1.0f - (currentCountDownTimeMS / ([[[[IntervalData getInstance] interval] time] totalTimeInSeconds] * 1000));
    [intervalometerCountDownViewController notifyOfInterruptToUpdateIntervalProgress:progress];
}

- (void) intervalometerIntervalInterrupt {
    
    
    
    
    
    
    
    shuttersTimer = [NSTimer scheduledTimerWithTimeInterval:interruptIntervalMS
                                                    target:self
                                                  selector:@selector(shutterInterrupt)
                                                  userInfo:nil
                                                   repeats:YES];
    
    
    
    [self startShutter];
    
}

- (void) shutterInterrupt {
    currentShutterTimeMS -= millisecondInterval;
    float progress = 0;
    if(currentShutterTimeMS <= 0) {
        currentShutterTimeMS = shutterLengthMS;
        [self clearShuttersTimer];
    }
    else {
        progress = currentShutterTimeMS / shutterLengthMS;
    }
    [intervalometerCountDownViewController notifyOfInterruptToUpdatShutterProgress:progress];

}

- (void) startShutter {
    
    Time * time;
    if([[[IntervalData getInstance] shutter] mode] == HDR_MODE &&
       hdrShutterIndex < [IntervalData getInstance].shutter.hdr.numberOfShots) {
        time = (Time *)[shutterTimes objectAtIndex:hdrShutterIndex];
        shutterTimer = [NSTimer scheduledTimerWithTimeInterval:[time totalTimeInSeconds] + [[[[IntervalData getInstance] shutter] hdr] shutterGap]
                                                        target:self
                                                      selector:@selector(startShutter)
                                                      userInfo:nil
                                                       repeats:NO];

        hdrShutterIndex++;
    }
    else if([[[IntervalData getInstance] shutter] mode] != HDR_MODE) {
        time = (Time *)[shutterTimes objectAtIndex:0];
    }
    else {
        hdrShutterIndex = 0;
        return;
    }
    
    if([[[IntervalData getInstance] shutter] mode] == BRAMP) {
        NSTimeInterval newTime = [[[[IntervalData getInstance] shutter] currentLength] totalTimeInSeconds] + brampingAlpha;    
        time = [[Time new] initWithTotalTimeInSeconds:newTime];
        [[[IntervalData getInstance] shutter] setCurrentLength:time];

    }
    
    [cameraController fireCamera:time];
}

- (void) getNotification {
    currentCountDownTimeSeconds = (int)[[IntervalData getInstance] duration];
    [self intervalometerDurationInterrupt];
}

- (void) clearShuttersTimer {
    [shuttersTimer invalidate];
    shuttersTimer = nil;
}

- (void) stopIntervalometer {
    [self clearShuttersTimer];
    [shutterTimer invalidate];
    shutterTimer = nil;
    [durationTimer invalidate];
    durationTimer = nil;
    [intervalTimer invalidate];
    intervalTimer = nil;
    [cameraController fireButtonDepressed];
    [intervalometerCountDownViewController notifyOfDurationEnd];
}

@end
