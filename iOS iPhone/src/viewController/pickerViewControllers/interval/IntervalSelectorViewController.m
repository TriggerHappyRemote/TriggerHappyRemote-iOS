//
//  TimeSelectorIntervalViewController.m
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "IntervalSelectorViewController.h"
#import "IntervalData.h"
#import "Time.h"
#import "InfoViewController.h"

@implementation IntervalSelectorViewController 

int hourOffSet;
int minuteOffSet;
int secondOffSet;

-(void) viewDidLoad {
    [super viewDidLoad];
    if(IDIOM == IPAD)
        infoViewController = [InfoViewController withLocationForPad:82 and:300];
    else
        infoViewController = [InfoViewController withLocationForPhone:0 and:277];
    
    infoViewController.type = InfoViewControllerInfo;
    [infoViewController setText:[[NSString alloc] initWithFormat:@"A photo will be taken every %@", [[self time] toStringDescriptive]]];
    [self.view addSubview:infoViewController.view];
}

-(void) initializeInstructionLabel {
    //self.instructionLabel.text = @"Interval off";
}

-(void) changeHour: (int) hour {
    [[[self.intervalData interval] time] setHours:hour+hourOffSet];
}

-(void) changeMinute: (int) minute {
    [[[self.intervalData interval] time] setMinutes:minute+minuteOffSet];

}

-(void) changeSecond: (int) second {
    [[[self.intervalData interval] time] setSeconds:second+secondOffSet];
}

-(Time *) time {
    return [[self.intervalData interval] time];
}

-(void) registerSegmentChangeToModel {
    [[self.intervalData interval] setIntervalEnabled:[self.segment selectedSegmentIndex] == 0];
}

-(int) getSegmentIndex { 
    if([[self.intervalData interval] intervalEnabled]) {
        return 0; // on
    }
    else {
        return 1; // off
    }
}

-(void) setPickerMode:(PickerMode)state {
    [[self.intervalData interval] setPickerMode:state];
}

-(PickerMode)getPickerMode {
    return [[self.intervalData interval] pickerMode];
}

-(void) loadHoursArray {
    // Hours 0-24
    self.hoursValues = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 0; i < 23; i++) {
        [self.hoursValues addObject:[NSString stringWithFormat:@"%i", i]];
    }
}

/* Upper then lower called by super class */
-(void) boundsCheck:(NSInteger)row inComponent:(NSInteger)component withPreviousLength:(Time *)time {
    
    Time * max = [[self.intervalData duration] time];
    
    if(![[self.intervalData duration] unlimitedDuration] && [[self time] totalTimeInSeconds] >= [max totalTimeInSeconds]) {
        // upper bounds off
        Time * newMax = [Time new];
        [newMax setTotalTimeInSeconds:[max totalTimeInSeconds] - 1];
        [self.picker selectRow:[newMax hours] inComponent:0 animated:false];
        [self.picker selectRow:[newMax minutes] inComponent:1 animated:false];
        [self.picker selectRow:[newMax seconds] inComponent:2 animated:false];
        [self changeHour:[newMax hours]];
        [self changeMinute:[newMax minutes]];
        [self changeSecond:[newMax seconds]];
        
        [infoViewController setText:[[NSString alloc] initWithFormat:@"Interval must be shorter than the duration of %@", [[[self.intervalData duration] time] toStringDescriptive]]];
        [infoViewController setType:InfoViewControllerWarning];
    }
    else if([[self time] totalTimeInSeconds] <= [[[self.intervalData shutter] getMaxTime] totalTimeInSeconds]) {
        // lower bounds off
        Time * newMax = [Time new];
        [newMax setTotalTimeInSeconds:[[[self.intervalData shutter] getMaxTime] totalTimeInSeconds] + 1];
        [self.picker selectRow:[newMax hours] inComponent:0 animated:false];
        [self.picker selectRow:[newMax minutes] inComponent:1 animated:false];
        [self.picker selectRow:[newMax seconds] inComponent:2 animated:false];
        [self changeHour:[newMax hours]];
        [self changeMinute:[newMax minutes]];
        [self changeSecond:[newMax seconds]];

        [infoViewController setText:[[NSString alloc] initWithFormat:@"Interval must be longer than the shutter of %@", [[[self.intervalData shutter] getMaxTime] toStringDescriptive]]];
        [infoViewController setType:InfoViewControllerWarning];
    }
    else {
        // in bounds
        [infoViewController setText:[[NSString alloc] initWithFormat:@"A photo will be taken every %@", [[self time] toStringDescriptive]]];
        
        [infoViewController setType:InfoViewControllerInfo];
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
