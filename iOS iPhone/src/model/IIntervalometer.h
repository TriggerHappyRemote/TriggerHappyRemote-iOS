//
//  IIntervalometer.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntervalometerCountDownViewController.h"
#import "IntervalData.h"

@interface IIntervalometer : NSObject

// so the view can listen to this for updating gui
- (void) setIntervalometerCountdownViewControllerReference: (IntervalometerCountDownViewController *) _view;

// start the intervalometer
- (void) startIntervalometer;

// stop the intervalometer
- (void) stopIntervalometer;

// method the view can call to reviece a call back updating the view
- (void) getNotification;

@end
