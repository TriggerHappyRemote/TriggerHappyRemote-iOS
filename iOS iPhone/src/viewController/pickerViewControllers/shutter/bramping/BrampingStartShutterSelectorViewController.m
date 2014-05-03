//
//  BrampingStartShutterSelectorViewController.m
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

#import "BrampingStartShutterSelectorViewController.h"
#import "IntervalData.h"
#import "InfoViewController.h"
#import "Shutter.h"
#import "Interval.h"

@implementation BrampingStartShutterSelectorViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    if(IDIOM == IPAD)
        infoViewController = [InfoViewController withLocationForPad:82 and:300];
    else
        infoViewController = [InfoViewController withLocationForPhone:0 and:277];
    
    infoViewController.type = InfoViewControllerInfo;
    [infoViewController setText:self.infoMessage];
    [self.view addSubview:infoViewController.view];
}

-(void) changeHour: (int) hour {
    [[[[[IntervalData getInstance] shutter] bramper] startShutterLength] setHours:hour];
    [IntervalData getInstance].shutter.startLength.hours = hour;
}

-(void) changeMinute: (int) minute {
    [[[[[IntervalData getInstance] shutter] bramper] startShutterLength] setMinutes:minute];
    [IntervalData getInstance].shutter.startLength.minutes = minute;
}

-(void) changeSecond: (int) second {
    [[[[[IntervalData getInstance] shutter] bramper] startShutterLength] setSeconds:second];
    [IntervalData getInstance].shutter.startLength.seconds = second;
}

-(void) changeMillisecond:(int)millisecond {
    [[[[[IntervalData getInstance] shutter] bramper] startShutterLength] setMilliseconds:millisecond];
    [IntervalData getInstance].shutter.startLength.milliseconds = millisecond;
}

-(Time *) time {
    return [[[[IntervalData getInstance] shutter] bramper] startShutterLength];
}

-(void) setPickerMode:(PickerMode)state {
    [[[[IntervalData getInstance] shutter] bramper] setPickerModeStart:state];
}

-(PickerMode)getPickerMode {
    return [[[[IntervalData getInstance] shutter] bramper] pickerModeStart];
}

- (NSString *) infoMessage {
    return [[NSString alloc] initWithFormat:@"The shutter at the start of the time lapse is %@", [[self time] toStringDescriptive]];
}

- (NSString *) warningMessage {
    return [[NSString alloc] initWithFormat:@"The start shutter length must be shorter than the interval of %@", [[IntervalData getInstance].interval.time toStringDescriptive]];
}

@end
