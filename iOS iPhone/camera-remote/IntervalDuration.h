//
//  IntervalDuration.h
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Time.h"

@interface IntervalDuration : NSObject

@property (nonatomic, strong) Time* time;
@property (nonatomic) bool unlimitedDuration;

@end
