//
//  Time.m
//  camera-remote
//
//  Created by Kevin Harrington on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Time.h"

@interface Time()
 -(void) timeComponentsChanged;
@end


@implementation Time

@synthesize totalTimeInSeconds = _totalTimeInSeconds;
@synthesize hours = _hours;
@synthesize minutes = _minutes;
@synthesize seconds = _seconds;
@synthesize milliseconds = _milliseconds;


-(id) init {
    NSLog(@"init");
    _milliseconds = 0;
    return self;
}

-(void) setTotalTimeInSeconds:(NSTimeInterval)totalTimeInSeconds {
    NSLog(@"Set total time in seconds: %f", totalTimeInSeconds);
    _totalTimeInSeconds = (int)totalTimeInSeconds;
    NSLog(@"Set total time in seconds: %f", self.totalTimeInSeconds);
    [self timeComponentsChanged];
    
}

-(void) timeComponentsChanged {
    _hours = (int)(self.totalTimeInSeconds / 3600);
    _minutes = (self.totalTimeInSeconds - self.hours * 3600) / 60; 
    _seconds = self.totalTimeInSeconds - self.hours * 3600 - self.minutes * 60;
    _milliseconds = self.totalTimeInSeconds - (int)self.totalTimeInSeconds;
    NSLog(@"updated time %i h %i m %i s", _hours, _minutes, _seconds);
    NSLog(@"updated time %i h %i m %i s", self.hours, self.minutes, self.seconds);

}

- (void) decrementSecond {
    [self setTotalTimeInSeconds:_totalTimeInSeconds - 1];
}

- (NSString *) toStringDownToMinutes {
    int hours = self.hours;
    int minutes = self.minutes;
    NSString *parsedTime;
    if(hours < 10 && minutes < 10) 
        parsedTime = [[NSString alloc]initWithFormat:@"0%i:0%i", hours, minutes];
    else if(hours < 10)
        parsedTime = [[NSString alloc]initWithFormat:@"0%i:%i", hours, minutes];
    else if(minutes < 10)
        parsedTime = [[NSString alloc]initWithFormat:@"%i:0%i", hours, minutes];
    else
        parsedTime = [[NSString alloc]initWithFormat:@"%i:%i", hours, minutes];
    
    NSLog(@"Returning this time %@", parsedTime);
    return parsedTime;
}

- (NSString *) toStringDownToSeconds {
    NSLog(@"STring conversions");
    NSString * seconds;
    if(self.seconds < 10) {
        seconds = [[NSString alloc]initWithFormat:@":0%i", self.seconds];
    }
    else {
        seconds = [[NSString alloc]initWithFormat:@":%i", self.seconds];
    }
    
    NSString * assembledTime = [[NSString alloc]initWithFormat:@"%@%@",[self toStringDownToMinutes], seconds];
    NSLog(@"Returning this time %@", assembledTime);

    return assembledTime;
}


@end
