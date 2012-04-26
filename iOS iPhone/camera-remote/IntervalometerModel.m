//
//  IntervalometerModel.m
//  camera-remote
//
//  Created by Kevin Harrington on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntervalometerModel.h"
#import "IntervalData.h"
#import "AppDelegate.h"
#import "Time.h"

@interface IntervalometerModel()
@property (nonatomic, strong) Time * remainingTime;
@end

@implementation IntervalometerModel

@synthesize remainingTime = _remainingTime;

IntervalometerCountDownViewController *intervalometerCountDownViewController;

NSTimer *durationTimer;
NSTimer *intervalTimer;
NSTimer *shutterTimer;


IntervalData *intervalData;

int currentCountDownTimeSeconds;
//miliseconds - up to 24 hours
int currentCountDownTimeMS;
int currentShutterTimeMS;
float interruptIntervalMS;
int millisecondInterval;
float shutterLengthMS;


- (id) init {
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
    _remainingTime = [Time new];    
    return self;
}

- (void) setIntervalometerCountdownViewControllerReference: (IntervalometerCountDownViewController *) _view {
    intervalometerCountDownViewController = _view;
    
}

- (void) startIntervalometer {
    interruptIntervalMS = .025;
    millisecondInterval = (int)(1000 * interruptIntervalMS);
    
    shutterLengthMS = [[intervalData shutterSpeed] totalTimeInSeconds] * 1000;
    
    currentShutterTimeMS = shutterLengthMS;
    
    
    if(![intervalData unlimitedDuration]) {
        currentCountDownTimeSeconds = (int)[intervalData duration];
        [self.remainingTime setTotalTimeInSeconds:[[[intervalData duration] time] totalTimeInSeconds]];

        currentCountDownTimeMS = [[intervalData shutterSpeed] totalTimeInSeconds] * 1000;
            
        durationTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                         target:self
                                                       selector:@selector(intervalometerDurationInterrupt)
                                                       userInfo:nil
                                                        repeats:YES];
    }
    
    intervalTimer = [NSTimer scheduledTimerWithTimeInterval:interruptIntervalMS
                                                     target:self
                                                   selector:@selector(intervalometerSubInterrupt)
                                                   userInfo:nil
                                                    repeats:YES];

}

- (void) intervalometerDurationInterrupt {
    currentCountDownTimeSeconds--;
    [self.remainingTime decrementSecond];
    
    if(currentCountDownTimeSeconds <= 0) {
        [self stopIntervalometer];
    }
    else {
        [intervalometerCountDownViewController notifyOfInterrupt:[self.remainingTime toStringDownToSeconds]];
    }
}

- (void) intervalometerSubInterrupt {
    currentCountDownTimeMS -= millisecondInterval;
    if(currentCountDownTimeMS <= 0) {
        currentCountDownTimeMS = 1000 * [[intervalData shutterSpeed] totalTimeInSeconds];
        [self intervalometerIntervalInterrupt];
    }
    
    float progress = 1.0f - (currentCountDownTimeMS / ([[intervalData shutterSpeed] totalTimeInSeconds] * 1000));
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
    NSLog(@"shutter interrupt: %i", currentShutterTimeMS);
    float progress = 0;
    if(currentShutterTimeMS <= 0) {
        currentShutterTimeMS = shutterLengthMS;
        [self stopShutter];
        [self clearShutterTimer];
    }
    else {
        progress = currentShutterTimeMS / shutterLengthMS;
    }
    [intervalometerCountDownViewController notifyOfInterruptToUpdatShutterProgress:progress];

}

- (void) startShutter {
    // TODO: Fire camera
    
    NSLog(@"start camera");
}

- (void) stopShutter {
    // TODO: Stop camera
    
    NSLog(@"stop shutter");
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
    NSLog(@"notifyOfDurationEnd()");
    [intervalometerCountDownViewController notifyOfDurationEnd];
}


@end
