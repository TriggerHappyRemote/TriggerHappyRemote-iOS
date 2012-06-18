//
//  IIntervalometer.m
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "IIntervalometer.h"
#import "IntervalData.h"
#import "AppDelegate.h"
#import "Time.h"
#import "ICameraController.h"

@interface IIntervalometer()
    @property (nonatomic, strong) Time * remainingTime;
    - (void) intervalometerDurationInterrupt;
    - (void) intervalometerIntervalInterrupt;
    - (void) intervalometerSubInterrupt;
    - (void) startShutter;
    - (void) shutterInterrupt;
- (void) clearShutterTimer;
@end

@implementation IIntervalometer

@synthesize remainingTime = _remainingTime;

IntervalometerCountDownViewController *intervalometerCountDownViewController;

NSTimer *durationTimer;
NSTimer *intervalTimer;
NSTimer *shutterTimer;

IntervalData *intervalData;
ICameraController * cameraController;

int currentCountDownTimeSeconds;
//miliseconds - up to 24 hours
int currentCountDownTimeMS;
int currentShutterTimeMS;
float interruptIntervalMS;
int millisecondInterval;
float shutterLengthMS;
float brampingAlpha;


- (id) init {
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
    cameraController = [intervalData cameraController];
    _remainingTime = [Time new];    
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
    
    shutterLengthMS = [[[intervalData shutter] currentLength] totalTimeInSeconds] * 1000;
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
    
    shutterTimer = [NSTimer scheduledTimerWithTimeInterval:interruptIntervalMS
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
        [self clearShutterTimer];
    }
    else {
        progress = currentShutterTimeMS / shutterLengthMS;
    }
    [intervalometerCountDownViewController notifyOfInterruptToUpdatShutterProgress:progress];

}

- (void) startShutter {
    
    NSTimeInterval newTime = [[[intervalData shutter] currentLength] totalTimeInSeconds] + brampingAlpha;    
    Time * updatedTime = [[Time new] initWithTotalTimeInSeconds:newTime];
    [[intervalData shutter] setCurrentLength:updatedTime];
    [cameraController fireCamera:[[intervalData shutter] currentLength]];
    NSLog(@"Shutter length: %f", [[[intervalData shutter] currentLength] totalTimeInSeconds] );
}

- (void) getNotification {
    currentCountDownTimeSeconds = (int)[intervalData duration];
    [self intervalometerDurationInterrupt];
}

- (void) clearShutterTimer {
    [shutterTimer invalidate];
    shutterTimer = nil;
}

- (void) stopIntervalometer {
    [self clearShutterTimer];
    [durationTimer invalidate];
    durationTimer = nil;
    [intervalTimer invalidate];
    intervalTimer = nil;
    [cameraController fireButtonDepressed];
    [intervalometerCountDownViewController notifyOfDurationEnd];
}


@end
