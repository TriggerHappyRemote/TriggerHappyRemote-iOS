//
//  IntervalData.h
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntervalometerCountDownViewController.h"
#import "Time.h"
#import "IntervalDuration.h"
#import "Interval.h"
#import "Shutter.h"
#import "ICameraController.h"

@interface IntervalData : NSObject

@property (nonatomic, strong) IntervalDuration* duration;
@property (nonatomic, strong) Interval* interval;
@property (nonatomic, strong) Shutter* shutter;

@property (nonatomic, strong) ICameraController* cameraController;

@property (nonatomic) CameraConrollerMode cameraContollerMode;

@end
