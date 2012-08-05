//
//  IIntervalometer.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "IIntervalometer.h"
#import "IntervalData.h"
#import "AppDelegate.h"
#import "Time.h"
#import "ICameraController.h"
#import "Shutter.h"
#import "Interval.h"
#import "IntervalDuration.h"

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
@synthesize intervalData;

IntervalometerCountDownViewController *intervalometerCountDownViewController;

NSTimer *durationTimer;
NSTimer *intervalTimer;
NSTimer *shuttersTimer;
NSTimer *shutterTimer;

//IntervalData *intervalData;
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
    intervalData = [IntervalData getInstance];
    cameraController = [intervalData cameraController];
    _remainingTime = [Time new];  
    shutterTimes = [[intervalData shutter] getShutterLengths];
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
    
    if([[intervalData shutter] mode] == HDR_MODE) {
        shutterLengthMS = [[[intervalData shutter] getMaxTime] totalTimeInSeconds] * 1000;
    }
    else {
        shutterLengthMS = [[[intervalData shutter] currentLength] totalTimeInSeconds] * 1000;
    }
    currentShutterTimeMS = shutterLengthMS;
    
    
    
    
    if([[intervalData shutter] mode] == BRAMP) {
        
        // DELTA = stop - start
        // NUM_INTERVALS = DURATION / Interval;
        // ALPHA = DELTA / NO_INTERVALS
        
        float delta = [[[[intervalData shutter] bramper] endShutterLength] totalTimeInSeconds] - [[[[intervalData shutter] bramper] startShutterLength] totalTimeInSeconds];
        
        
        float num_intervals = [[[intervalData duration] time] totalTimeInSeconds] / [[[intervalData interval] time] totalTimeInSeconds] - 1;
        brampingAlpha = delta / num_intervals;

        
    }
    else {
        brampingAlpha = 0.0;
    }
    
    [[intervalData shutter] initializeCurrentLength];
    [[intervalData shutter] currentLength].totalTimeInSeconds -= brampingAlpha;
    
    currentCountDownTimeMS = [[[intervalData interval] time] totalTimeInSeconds] * 1000;
    
    if(![[intervalData duration] unlimitedDuration] && [[intervalData interval] intervalEnabled]) {
        
        currentCountDownTimeSeconds = [[[intervalData duration] time] totalTimeInSeconds];
        [self.remainingTime setTotalTimeInSeconds:[[[intervalData duration] time] totalTimeInSeconds]];
        
        durationTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                         target:self
                                                       selector:@selector(intervalometerDurationInterrupt)
                                                       userInfo:nil
                                                        repeats:YES];
    }
    
    if([[intervalData interval] intervalEnabled]) {
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
        currentCountDownTimeMS = [[[intervalData interval] time] totalTimeInSeconds] * 1000;

        [self intervalometerIntervalInterrupt];
    }
    
    // not matter what we always update the slider to indicate the slider progress
    float progress = 1.0f - (currentCountDownTimeMS / ([[[intervalData interval] time] totalTimeInSeconds] * 1000));
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
    if([[intervalData shutter] mode] == HDR_MODE &&
       hdrShutterIndex < [[[intervalData shutter] hdr] numberOfShots]) {
        
        NSLog(@"Shutter index: %i", hdrShutterIndex );
        NSLog(@"shutters count: %i", [shutterTimes count] );

        time = (Time *)[shutterTimes objectAtIndex:hdrShutterIndex];

        
        shutterTimer = [NSTimer scheduledTimerWithTimeInterval:[time totalTimeInSeconds] + [[[intervalData shutter] hdr] shutterGap]
                                                        target:self
                                                      selector:@selector(startShutter)
                                                      userInfo:nil
                                                       repeats:NO];

        hdrShutterIndex++;
    }
    else if([[intervalData shutter] mode] != HDR_MODE) {
        time = (Time *)[shutterTimes objectAtIndex:0];
    }
    else {
        hdrShutterIndex = 0;
        return;
    }
    
    if([[intervalData shutter] mode] == BRAMP) {
        NSTimeInterval newTime = [[[intervalData shutter] currentLength] totalTimeInSeconds] + brampingAlpha;    
        time = [[Time new] initWithTotalTimeInSeconds:newTime];
        [[intervalData shutter] setCurrentLength:time];

    }
    [cameraController fireCamera:time];
    NSLog(@"Shutter length: %f", [time totalTimeInSeconds] );
}

- (void) getNotification {
    currentCountDownTimeSeconds = (int)[intervalData duration];
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
