//
//  IntervalDuration.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Time.h"

@interface IntervalDuration : NSObject

@property (nonatomic, strong) Time* time;
@property (nonatomic) bool unlimitedDuration;

@end
