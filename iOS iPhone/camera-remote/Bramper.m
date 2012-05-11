//
//  Bramper.m
//  Trigger Happy, V1.0
//
//  Created by Kevin Harrington on 4/27/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "Bramper.h"

@implementation Bramper

@synthesize endShutterLength = _endShutterLength;
@synthesize startShutterLength = _startShutterLength;
@synthesize pickerModeStop = _pickerModeStop;
@synthesize pickerModeStart = _pickerModeStart;

-(id) init {
    
    _endShutterLength = [Time new];
    _startShutterLength = [Time new];
    _pickerModeStart = SECONDS;
    _pickerModeStop = SECONDS;
    return self;
}

- (NSString *) getStartShutterLabelText {
    if(self.pickerModeStart == SECONDS) {
        return [self.startShutterLength toStringDownToSeconds];
    }
    return [self.startShutterLength toStringDownToMilliseconds];

    
}
- (NSString *) getEndShutterLabelText {
    if(self.pickerModeStop == SECONDS) {
        return [self.endShutterLength toStringDownToSeconds];
    }
    return [self.endShutterLength toStringDownToMilliseconds];
}

@end
