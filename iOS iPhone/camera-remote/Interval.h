//
//  Interval.h
//  Trigger Happy V1.0
//
//  Created by Kevin Harrington on 4/26/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//
//  Container class for data needed to represent an intervalometer interval
//


#import <Foundation/Foundation.h>
#import "Time.h"
#import "Constants.h"

@interface Interval : NSObject


@property (nonatomic, strong) Time* time;
@property (nonatomic) bool intervalEnabled;

@property (nonatomic) PickerMode pickerMode;

-(NSString*) getButtonData;

@end
