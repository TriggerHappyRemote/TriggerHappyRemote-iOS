//
//  BrampingStartShutterSelectorViewController.m
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "BrampingStartShutterSelectorViewController.h"
#import "IntervalData.h"

@implementation BrampingStartShutterSelectorViewController

-(void) changeHour: (int) hour {
    [[[[self.intervalData shutter] bramper] startShutterLength] setHours:hour];
}

-(void) changeMinute: (int) minute {
    [[[[self.intervalData shutter] bramper] startShutterLength] setMinutes:minute];
    
}

-(void) changeSecond: (int) second {
    [[[[self.intervalData shutter] bramper] startShutterLength] setSeconds:second];
}

-(void) changeMillisecond:(int)millisecond {
    [[[[self.intervalData shutter] bramper] startShutterLength] setMilliseconds:millisecond];
}

-(Time *) time {
    return [[[self.intervalData shutter] bramper] startShutterLength];
}

-(void) setPickerMode:(PickerMode)state {
    [[[self.intervalData shutter] bramper] setPickerModeStart:state];
}

-(PickerMode)getPickerMode {
    return [[[self.intervalData shutter] bramper] pickerModeStart];
}

@end
