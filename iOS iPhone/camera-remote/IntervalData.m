//
//  IntervalData.m
//  
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 TriggerHappy. All rights reserved.
//

#import "IntervalData.h"

@implementation IntervalData

@synthesize interval = _interval;
@synthesize duration = _duration;
@synthesize shutterSpeed = _shutterSpeed;

@synthesize unlimitedDuration = _unlimitedDuration;
@synthesize autoShutter = _autoShutter;




@synthesize isThirdStop, exposureValue, numberOfShots;

- (id)init {
    _interval = [Time new];
    _duration = [Time new];
    _shutterSpeed = [Time new];

    
    
    self.duration.totalTimeInSeconds = 3600;
    self.unlimitedDuration = true;
    self.shutterSpeed.totalTimeInSeconds = .01;
    self.interval.totalTimeInSeconds = 3;
    self.autoShutter = true;
    self.shutterSpeed.totalTimeInSeconds = 2;
    
    
    isThirdStop = true;
    numberOfShots = 1;
    exposureValue = 1;
    
    return self;
}

- (bool) isThirdStop {
    return isThirdStop;
}

- (void) toggleThirdStop {
    isThirdStop = !isThirdStop;
}


//HDR

- (void) setNumberOfShots : (int) _numberOfShots {
    numberOfShots = _numberOfShots;
}

- (int) getNumberOfShots {
    return numberOfShots;
}

- (void) setEV : (int) _EV {
    exposureValue = _EV;
}

- (int) getEV {
    return exposureValue;
}



@end


