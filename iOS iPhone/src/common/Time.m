//
//  Time.m
//  Copyright (c) 2014 Kevin Harrington
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  Created by Kevin Harrington on 1/9/12.
//  
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
    NSString * milliseconds;
    if(self.milliseconds < 100) {
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


- (NSString *) toStringDescriptive {
    NSMutableString * timeDescription = [[NSMutableString alloc] initWithFormat:@"" ];
    
    if(self.hours > 1) {
        [timeDescription appendFormat:@"%i hours ", self.hours];
    }
    else if(self.hours > 0) {
        [timeDescription appendFormat:@"1 hour "];
    }
    
    if(self.minutes > 1) {
        [timeDescription appendFormat:@"%i minutes ", self.minutes];
    }
    else if(self.minutes > 0) {
        [timeDescription appendFormat:@"1 minute "];
    }
    
    if(self.seconds > 1) {
        [timeDescription appendFormat:@"%i seconds ", self.seconds];
    }
    else if(self.seconds > 0) {
        [timeDescription appendFormat:@"1 second "];
    }
    
    if(self.milliseconds > 1) {
        [timeDescription appendFormat:@"%i milliseconds ", self.milliseconds];
    }
    else if(self.milliseconds > 0) {
        [timeDescription appendFormat:@"1 millisecond "];
    }
    
    
    
    return timeDescription;
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
