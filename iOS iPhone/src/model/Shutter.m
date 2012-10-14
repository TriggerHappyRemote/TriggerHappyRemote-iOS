//
//  Shutter.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "Shutter.h"
#import "AppDelegate.h"

@implementation Shutter

@synthesize startLength = _startLength;
@synthesize bulbMode = _bulbMode;
@synthesize mode = _mode;

@synthesize bramper = _bramper;
@synthesize hdr = _hdr;
@synthesize pickerMode;
@synthesize currentLength = _currentLength;
@synthesize defaultShutterLength;


-(id) init {
    _mode = STANDARD;
    _bulbMode = NO;
    _startLength = [Time new];
    _bramper = [Bramper new];
    _hdr = [HDR new];
    self.pickerMode = SECONDS;
    self.defaultShutterLength = [Time new];
    self.defaultShutterLength.totalTimeInSeconds = .3;
    return self;
}

-(void) initializeCurrentLength {
    _currentLength = [Time new];
    _currentLength.totalTimeInSeconds = _startLength.totalTimeInSeconds;
}

-(NSString*) getButtonData {
    if(self.bulbMode) {
        if(self.pickerMode == SECONDS)
            return [self.startLength toStringDownToSeconds];
        return [self.startLength toStringDownToMilliseconds];
    }
    else {
        return [[NSString alloc] initWithFormat:@"Auto"];
    }
}

-(Time*) getMaxTime {
    if(self.mode == STANDARD) { // Standard shutter
        if(self.bulbMode)
            return self.startLength;
        else
            return self.defaultShutterLength;
    }
    else if(self.mode == BRAMP) { // Bramping
        if(self.bramper.startShutterLength.totalTimeInSeconds > 
           self.bramper.endShutterLength.totalTimeInSeconds) {
            return self.bramper.startShutterLength;
        }
        else {
            return self.bramper.endShutterLength;
        }
    }
    else {
        return [[Time alloc] initWithTotalTimeInSeconds:[self.hdr getMaxShutterLength]];
    }
}

- (NSMutableArray *) getShutterLengths {
    if(self.mode == STANDARD) { // Standard shutter
        if(self.bulbMode)
            return [NSMutableArray arrayWithObject:self.startLength];
        else
            return [NSMutableArray arrayWithObject:self.defaultShutterLength];
    }
    else if(self.mode == BRAMP) { // Bramping
        return [NSMutableArray arrayWithObject:[self.bramper startShutterLength]];

    }
    else {
        return [self.hdr getShutterLengths];
    }
}

@end
