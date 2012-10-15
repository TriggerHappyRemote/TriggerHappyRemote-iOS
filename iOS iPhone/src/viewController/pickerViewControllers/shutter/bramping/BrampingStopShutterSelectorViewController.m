//
//  BrampingStopShutterSelectorViewController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "BrampingStopShutterSelectorViewController.h"
#import "IntervalData.h"
#import "InfoViewController.h"
#import "Shutter.h"
#import "Interval.h"

@implementation BrampingStopShutterSelectorViewController

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
    [[[[[IntervalData getInstance] shutter] bramper] endShutterLength] setHours:hour];
}

-(void) changeMinute: (int) minute {
    [[[[[IntervalData getInstance] shutter] bramper] endShutterLength] setMinutes:minute];
    
}

-(void) changeSecond: (int) second {
    [[[[[IntervalData getInstance] shutter] bramper] endShutterLength] setSeconds:second];
}

-(void) changeMillisecond:(int)millisecond {
    [[[[[IntervalData getInstance] shutter] bramper] endShutterLength] setMilliseconds:millisecond];
}

-(Time *) time {
    return [[[[IntervalData getInstance] shutter] bramper] endShutterLength];
}

-(void) setPickerMode:(PickerMode)state {
    [[[[IntervalData getInstance] shutter] bramper] setPickerModeStop:state];
}

-(PickerMode)getPickerMode {
    return [[[[IntervalData getInstance] shutter] bramper] pickerModeStop];
}

- (NSString *) infoMessage {
    return [[NSString alloc] initWithFormat:@"The shutter at the end of the time lapse is %@", [[self time] toStringDescriptive]];
}

- (NSString *) warningMessage {
    return [[NSString alloc] initWithFormat:@"The end shutter length must be shorter than the interval of %@", [[IntervalData getInstance].interval.time toStringDescriptive]];
}

@end
