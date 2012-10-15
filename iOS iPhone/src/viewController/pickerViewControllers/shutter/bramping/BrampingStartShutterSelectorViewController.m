//
//  BrampingStartShutterSelectorViewController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
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
