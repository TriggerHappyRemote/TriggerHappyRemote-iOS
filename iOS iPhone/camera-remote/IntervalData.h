//
//  IntervalData.h
//  Trigger Happy, LLC
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntervalometerCountDownViewController.h"
#import "Time.h"
#import "IntervalDuration.h"
#import "Interval.h"
#import "Shutter.h"
#import "AudioOutputController.h"

@interface IntervalData : NSObject

@property (nonatomic, strong) IntervalDuration* duration;
@property (nonatomic, strong) Interval* interval;
@property (nonatomic, strong) Shutter* shutter;

@property (nonatomic, strong) AudioOutputController* audioOutput;


@end
