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
-(void) updateTotalTimeInSeconds;
@end


@implementation Time

@synthesize totalTimeInSeconds = _totalTimeInSeconds;
@synthesize hours = _hours;
@synthesize minutes = _minutes;
@synthesize seconds = _seconds;
@synthesize milliseconds = _milliseconds;
@synthesize unlimited = _unlimited;

-(id) init {
    self = [super init];
    _unlimited = false;
    return self;
}

-(Time *) initWithTotalTimeInSeconds:(NSTimeInterval) totalTime {
    self = [super init];
    [self setTotalTimeInSeconds:totalTime];
    _unlimited = false;
    return self;
}



-(id) initUnlimited {
    _unlimited = true;
    return self;
}

-(void) setTotalTimeInSeconds:(NSTimeInterval)totalTimeInSeconds {
    _totalTimeInSeconds = totalTimeInSeconds;
    [self timeComponentsChanged];
}

- (NSTimeInterval) totalTimeInSeconds {    
    return _totalTimeInSeconds;
}

-(void) timeComponentsChanged {
    _hours = (int)(_totalTimeInSeconds / 3600);
    _minutes = (_totalTimeInSeconds - self.hours * 3600) / 60; 
    _seconds = _totalTimeInSeconds - self.hours * 3600 - self.minutes * 60;
    
    NSLog(@"Setting milliseconds: %f", _totalTimeInSeconds);
    NSLog(@"\t milliseconds: %i", _milliseconds);
    NSLog(@"\t 1: %f", (float)(int)(_totalTimeInSeconds* 1000));
    NSLog(@"\t 2: %f", _totalTimeInSeconds * 1000);
    

    _milliseconds = (int)((_totalTimeInSeconds* 1000) - (float)(int)_totalTimeInSeconds * 1000);

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
    
    return parsedTime;
}

- (NSString *) toStringDownToSeconds {
    NSString * seconds;
    if(self.seconds < 10) {
        seconds = [[NSString alloc]initWithFormat:@":0%i", self.seconds];
    }
    else {
        seconds = [[NSString alloc]initWithFormat:@":%i", self.seconds];
    }
    
    NSString * assembledTime = [[NSString alloc]initWithFormat:@"%@%@",[self toStringDownToMinutes], seconds];

    return assembledTime;
}

- (NSString *) toStringDownToMilliseconds {
    NSLog(@"Milliseconds %d", self.milliseconds);
    NSLog(@"Milliseconds %i", self.milliseconds);

    NSString * milliseconds;
    if(self.milliseconds < 10) {
        milliseconds = [[NSString alloc]initWithFormat:@":0%i", self.milliseconds];
    }
    else {
        milliseconds = [[NSString alloc]initWithFormat:@":%i", self.milliseconds];
    }
    
    NSString * assembledTime = [[NSString alloc]initWithFormat:@"%@%@",[self toStringDownToSeconds], milliseconds];
    assembledTime = [assembledTime substringFromIndex:3];
    
    //  assembleTime hh:mm:ss:ms
    if([assembledTime length] > 8) {
        assembledTime = [assembledTime substringToIndex:8];
    }
    return assembledTime;
}


-(void) setHours:(int)hours {
    _hours = hours; 
    [self updateTotalTimeInSeconds];
}

-(void) setMinutes:(int)minutes {
    _minutes = minutes;  
    [self updateTotalTimeInSeconds];
}

-(void) setSeconds:(int)seconds {
    _seconds = seconds;
    [self updateTotalTimeInSeconds];
}

-(void) setMilliseconds:(int)milliseconds {
    _milliseconds = milliseconds;   
    [self updateTotalTimeInSeconds];
}

-(void) updateTotalTimeInSeconds {
    _totalTimeInSeconds = _hours * 3600 + _minutes * 60 + _seconds + ((double)_milliseconds) / 1000;
}


@end
