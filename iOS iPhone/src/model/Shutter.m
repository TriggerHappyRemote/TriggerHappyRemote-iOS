//
//  Shutter.m
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
