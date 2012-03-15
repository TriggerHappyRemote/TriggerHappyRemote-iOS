//
//  IntervalData.m
//  camera-remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntervalData.h"

@implementation IntervalData

@synthesize duration, unlimitedDuration, interval, shutterSpeed,
            intervalHours, intervalMinutes, intervalSeconds,
            shutterHours, shutterMinutes, shutterSeconds, autoShutter,
            isThirdStop, exposureValue, numberOfShots;

- (id)init {
    shutterSpeed = .01;
    duration = 3600;
    unlimitedDuration = true;
    intervalMinutes = 0;
    intervalSeconds = 3;
    intervalHours = 0;
    autoShutter = true;
    shutterHours = 0;
    shutterMinutes = 0;
    shutterSeconds = 2;
    isThirdStop = true;
    numberOfShots = 1;
    exposureValue = 1;
    
    return self;
}

- (NSTimeInterval) getDuration {
    return duration;
}

- (bool) isThirdStop {
    return isThirdStop;
}

- (void) toggleThirdStop {
    isThirdStop = !isThirdStop;
}

- (NSString *) getDurationStringParsed {
    NSString *parsedTime;
    if(![self isUnlimitedDuration]) {
        int hours = (int)((int)duration / 3600.0f);
        int minutes = (int)((duration - ((NSTimeInterval)hours * 3600.0f)) / 60); 
        parsedTime = [[NSString alloc]initWithFormat:@"Duration: %i h %i m    >", hours, minutes];
    }
    else {
        parsedTime = [[NSString alloc]initWithFormat:@"Duration: Unlimited"];
    }    
    return parsedTime;
}

- (NSString *) getDurationStringParsedForCountDown {
    int hours = (int)((int)duration / 3600.0f);
    int minutes = (int)((duration - ((NSTimeInterval)hours * 3600.0f)) / 60); 
    NSString *parsedTime;
    if(hours < 10 && minutes < 10) 
        parsedTime = [[NSString alloc]initWithFormat:@"0%i:0%i", hours, minutes];
    else if(hours < 10)
        parsedTime = [[NSString alloc]initWithFormat:@"0%i:%i", hours, minutes];
    else if(minutes < 10)
        parsedTime = [[NSString alloc]initWithFormat:@"%i:0%i", hours, minutes];
    else
        parsedTime = [[NSString alloc]initWithFormat:@"%i:%i", hours, minutes];
    return parsedTime;
}

- (int) getIntervalSeconds {
    return intervalSeconds;
}

- (int) getIntervalMinutes {
    return intervalMinutes;
}

- (int) getIntervalHours {
    return intervalHours;
}

-(void) setIntervalHours: (int) hours {
    intervalHours = hours;
}

-(void) setIntervalMinutes: (int) minutes {
    intervalMinutes = minutes;
}

-(void) setIntervalSeconds: (int) seconds {
    intervalSeconds = seconds;
}

- (NSTimeInterval) getIntervalInSeconds {
    return (NSTimeInterval)(intervalHours * 3600 + intervalMinutes * 60 + intervalSeconds);
}

- (NSString *) getIntervalStringParsed {
    
    NSString * iHoursStr;
    if(intervalHours < 10)
        iHoursStr = [[NSString alloc] initWithFormat:@"0%i", intervalHours];
    else
        iHoursStr = [[NSString alloc] initWithFormat:@"%i", intervalHours];
    
    NSString * iMinsStr;
    if(intervalMinutes < 10)
        iMinsStr = [[NSString alloc] initWithFormat:@"0%i", intervalMinutes];
    else
        iMinsStr = [[NSString alloc] initWithFormat:@"%i", intervalMinutes];

    
    NSString * iSecStr;
    if(intervalSeconds < 10)
        iSecStr = [[NSString alloc] initWithFormat:@"0%i", intervalSeconds];
    else
        iSecStr = [[NSString alloc] initWithFormat:@"%i", intervalSeconds];

    return [[NSString alloc] initWithFormat:@"%@:%@:%@", iHoursStr, iMinsStr, iSecStr];
    
    
    
    

}

- (NSString *) getShutterStringParsed {
    if(autoShutter) {
            return @"Auto";
    }
    
    NSString * iHoursStr;
    if(shutterHours < 10)
        iHoursStr = [[NSString alloc] initWithFormat:@"0%i", shutterHours];
    else
        iHoursStr = [[NSString alloc] initWithFormat:@"%i", shutterHours];
    
    NSString * iMinsStr;
    if(shutterMinutes < 10)
        iMinsStr = [[NSString alloc] initWithFormat:@"0%i", shutterMinutes];
    else
        iMinsStr = [[NSString alloc] initWithFormat:@"%i", shutterMinutes];
    
    
    NSString * iSecStr;
    if(shutterSeconds < 10)
        iSecStr = [[NSString alloc] initWithFormat:@"0%i", shutterSeconds];
    else
        iSecStr = [[NSString alloc] initWithFormat:@"%i", shutterSeconds];
    
    return [[NSString alloc] initWithFormat:@"%@:%@:%@", iHoursStr, iMinsStr, iSecStr];
}

- (NSString *) getDurationStringParsed2 {
    return @"";
}


- (void) setDuration: (NSTimeInterval) dur {
    duration = dur;
}

- (bool) isUnlimitedDuration {
    return unlimitedDuration;
}

- (void) setUnlimitedDuration: (bool) unlimit {
    unlimitedDuration = unlimit;
}

- (NSTimeInterval) getShutterSpeed {
    return shutterSpeed;
}

//-----------------
// interval
// ----------------


- (int) getShutterSeconds {
    return shutterSeconds;
}

- (int) getShutterMinutes {
    return shutterMinutes;
}

- (int) getShutterHours {
    return shutterHours;
}

- (NSTimeInterval) getShutterInSeconds {
    if(!autoShutter)
        return shutterHours * 3600 + shutterMinutes * 60 + shutterSeconds;
    
    // default signal length with auto shutter
    return 1;
}

-(void) setShutterHours: (int) hours {
    shutterHours = hours;
}

-(void) setShutterMinutes: (int) minutes {
    shutterMinutes = minutes;
}

-(void) setShutterSeconds: (int) seconds {
    shutterSeconds = seconds;
}

- (bool) isAutoShutter {
    return autoShutter;
}

- (void) setAutoShutter: (bool) unlimit {
    autoShutter = unlimit;
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


