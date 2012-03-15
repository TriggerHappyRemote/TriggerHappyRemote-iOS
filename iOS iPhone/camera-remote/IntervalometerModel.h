//
//  IntervalometerModel.h
//  camera-remote
//
//  Created by Kevin Harrington on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntervalometerCountDownViewController.h"

@interface IntervalometerModel : NSObject {
    
}

- (void) setIntervalometerCountdownViewControllerReference: (IntervalometerCountDownViewController *) _view;

- (void) startIntervalometer;

- (void) stopIntervalometer;

- (void) intervalometerDurationInterrupt;

- (void) intervalometerIntervalInterrupt;

- (void) getNotification;

- (void) intervalometerSubInterrupt;

- (void) clearShutterTimer;

- (void) startShutter;

- (void) stopShutter;

- (void) shutterInterrupt;


@end
