//
//  HDR.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Time.h"
#import "Constants.h"

@interface HDR : NSObject

// number of shots
@property (nonatomic) int numberOfShots;

// ev interval
@property (nonatomic) double evInterval;

// base shutter speed
@property (nonatomic, strong) Time* baseShutterSpeed;
@property (nonatomic) bool bulb;

-(NSString*) getButtonData;

-(NSTimeInterval) getMaxShutterLength;

@property (nonatomic) PickerMode pickerMode;

// time between each shot
@property (nonatomic) NSTimeInterval shutterGap;

- (NSMutableArray *) getShutterLengths;

@end
