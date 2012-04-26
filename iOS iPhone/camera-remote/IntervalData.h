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

@interface IntervalData : NSObject

// Corresponds exactly with UISegmentControl settings in IntervalometerViewController
typedef enum  {
    STANDARD = 0,
    HDR = 1,
    BRAMP = 2
} IntervalometerMode;
@property (nonatomic) IntervalometerMode mode;



@property (nonatomic, strong) IntervalDuration* duration;
@property (nonatomic, strong) Interval* interval;



@property (nonatomic, strong) Time* shutterSpeed;


@end
