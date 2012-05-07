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
AudioOutputController * audioOutput;

int currentCountDownTimeSeconds;
//miliseconds - up to 24 hours
int currentCountDownTimeMS;
int currentShutterTimeMS;
float interruptIntervalMS;
int millisecondInterval;
float shutterLengthMS;


- (id) init {
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
    audioOutput = [intervalData audioOutput];
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
    
    // TODO: MUST CHANGE WITH BRAMPING
    shutterLengthMS = [[[intervalData shutter] startLength] totalTimeInSeconds] * 1000;
    currentShutterTimeMS = shutterLengthMS;
    
    
    
    if(![[intervalData duration] unlimitedDuration]) {
        currentCountDownTimeSeconds = [[[intervalData duration] time] totalTimeInSeconds];
        [self.remainingTime setTotalTimeInSeconds:[[[intervalData duration] time] totalTimeInSeconds]];

        currentCountDownTimeMS = [[[intervalData interval] time] totalTimeInSeconds] * 1000;
                
        NSLog(@"Start length: %f",[[[intervalData duration] time] totalTimeInSeconds] );
            
        durationTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                         target:self
                                                       selector:@selector(intervalometerDurationInterrupt)
                                                       userInfo:nil
                                                        repeats:YES];
         
    }
    
    // interval timer is constant
    
    
    intervalTimer = [NSTimer scheduledTimerWithTimeInterval:interruptIntervalMS
                                                     target:self
                                                   selector:@selector(intervalometerSubInterrupt)
                                                   userInfo:nil
                                                    repeats:YES];
    
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
    
    
    [audioOutput fireCamera:[[intervalData shutter] startLength]];

    
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
    [audioOutput abortShutter];
    NSLog(@"notifyOfDurationEnd()");
    [intervalometerCountDownViewController notifyOfDurationEnd];
}


@end
