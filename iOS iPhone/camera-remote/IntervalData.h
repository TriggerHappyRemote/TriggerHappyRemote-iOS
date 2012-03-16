//
//  IntervalData.h
//  camera-remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntervalometerCountDownViewController.h"
#import "Time.h"

@interface IntervalData : NSObject


// ---------------------------------------------------------
// Interval
// ---------------------------------------------------------



// ---------------------------------------------------------
// Duration
// ---------------------------------------------------------



// ---------------------------------------------------------

// --------------------------------------------------------
// HDR

- (bool) isThirdStop;

- (void) toggleThirdStop;

- (void) setNumberOfShots : (int) _numberOfShots;

- (int) getNumberOfShots;

- (void) setEV : (int) _EV;

- (int) getEV;

@property (nonatomic, strong) Time* duration;
@property (nonatomic, strong) Time* interval;
@property (nonatomic, strong) Time* shutterSpeed;



@property (nonatomic) bool unlimitedDuration;
@property (nonatomic) bool autoShutter;
@property (nonatomic) bool isThirdStop;

@property (nonatomic) int numberOfShots;

// base 3
@property (nonatomic) int exposureValue;



@end
