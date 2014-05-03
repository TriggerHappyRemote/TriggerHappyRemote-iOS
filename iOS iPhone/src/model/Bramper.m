//
//  Bramper.m
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

#import "Bramper.h"
#import "Time.h"

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
