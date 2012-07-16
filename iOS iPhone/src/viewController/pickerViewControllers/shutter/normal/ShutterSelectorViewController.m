//
//  ShutterSelectorViewController.m
//  Trigger Happy, V1.0
//
//  Created by Kevin Harrington on 4/27/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "ShutterSelectorViewController.h"
#import "IntervalData.h"
#import "InfoViewController.h"

@implementation ShutterSelectorViewController

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

-(void) initializeInstructionLabel {
    //self.instructionLabel.text = @"shutter selector - auto shutter";
}

-(void) changeHour: (int) hour {
    [[[self.intervalData shutter] startLength] setHours:hour];
}

-(void) changeMinute: (int) minute {
    [[[self.intervalData shutter] startLength] setMinutes:minute];
    
}

-(void) changeSecond: (int) second {
    [[[self.intervalData shutter] startLength] setSeconds:second];
}

-(void) changeMillisecond:(int)millisecond {
    [[[self.intervalData shutter] startLength] setMilliseconds:millisecond];
}

-(Time *) time {
    return [[self.intervalData shutter] startLength];
}

-(void) registerSegmentChangeToModel {
    [[self.intervalData shutter] setBulbMode:[self.segment selectedSegmentIndex] == 0];
}

-(int) getSegmentIndex { 
    if([[self.intervalData shutter] bulbMode]) {
        return 0; // bulb
    }
    else {
        return 1; // auto
    }
}

-(void) setPickerMode:(PickerMode) state {
    [[self.intervalData shutter] setPickerMode:state];
    
}

-(PickerMode)getPickerMode {
    return [[self.intervalData shutter] pickerMode];
}

- (NSString *) infoMessage {
    return [[NSString alloc] initWithFormat:@"Each photo will have a %@shutter length", [[self time] toStringDescriptive]];
}

- (NSString *) warningMessage {
    return [[NSString alloc] initWithFormat:@"Shutter must be shorter than the %@ interval", [self.intervalData.interval.time toStringDescriptive]];
}

@end
