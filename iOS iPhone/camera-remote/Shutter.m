//
//  Shutter.m
//  Trigger Happy, V1.0
//
//  Created by Kevin Harrington on 4/27/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "Shutter.h"

@implementation Shutter

@synthesize startLength = _startLength;
@synthesize bulbMode = _bulbMode;
@synthesize mode = _mode;

@synthesize bramper = _bramper;
@synthesize hdr = _hdr;
@synthesize pickerMode;

-(id) init {
    _mode = STANDARD;
    _bulbMode = false;
    _startLength = [Time new];
    _bramper = [Bramper new];
    _hdr = [HDR new];
    self.pickerMode = SECONDS;
    return self;
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

@end
