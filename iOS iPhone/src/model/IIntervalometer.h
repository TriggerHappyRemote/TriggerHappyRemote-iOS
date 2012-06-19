//
//  IIntervalometer.h
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
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

@property (nonatomic, strong) IntervalData * intervalData;


@end
