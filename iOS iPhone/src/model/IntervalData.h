//
//  IntervalData.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

@class ICameraController;
@class Shutter;
@class Interval;
@class IntervalDuration;

@interface IntervalData : NSObject

@property (nonatomic, strong) IntervalDuration* duration;
@property (nonatomic, strong) Interval* interval;
@property (nonatomic, strong) Shutter* shutter;

@property (nonatomic, strong) ICameraController* cameraController;

+ (IntervalData *)getInstance;

@end
