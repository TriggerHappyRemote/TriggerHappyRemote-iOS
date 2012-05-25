//
//  HDR.h
//  Trigger Happy, V1.0
//
//  Created by Kevin Harrington on 4/27/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Time.h"

@interface HDR : NSObject

// number of shots
@property (nonatomic) int numberOfShots;

// ev interval
@property (nonatomic) double evInterval;

// base shutter speed
@property (nonatomic, strong) Time* baseShutterSpeed;
@property (nonatomic) bool bulb;

-(NSString*) getButtonData;

-(Time*) getMaxShutterLength;

@end