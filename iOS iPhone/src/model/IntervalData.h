//
//  IntervalData.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

@class Shutter;
@class Interval;
@class IntervalDuration;

@interface IntervalData : NSObject

@property (nonatomic, strong) IntervalDuration* duration;
@property (nonatomic, strong) Interval* interval;
@property (nonatomic, strong) Shutter* shutter;

+ (IntervalData *)getInstance;
+ (void) switchInstance:(BOOL)timeLapseInstance;

@end
