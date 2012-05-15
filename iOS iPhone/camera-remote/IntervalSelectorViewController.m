//
//  TimeSelectorIntervalViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntervalSelectorViewController.h"

@implementation IntervalSelectorViewController 

int hourOffSet;
int minuteOffSet;
int secondOffSet;

-(void) initializeInstructionLabel {
    self.instructionLabel.text = @"Interval off";
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

-(void) lowerBoundsCheck:(NSInteger)row
             inComponent:(NSInteger)component {
    if([[self time] totalTimeInSeconds] <= [[[self.intervalData shutter] getMaxTime] totalTimeInSeconds]) {
        
        Time * min = [[self.intervalData shutter] getMaxTime];
        [self.picker selectRow:[min hours] inComponent:0 animated:false];
        [self.picker selectRow:[min minutes] inComponent:1 animated:false];
        [self.picker selectRow:[min seconds]+1 inComponent:2 animated:false];
        
        [self changeHour:[min hours]];
        [self changeMinute:[min minutes]];
        [self changeSecond:[min seconds]+1];
    }
    
}

@end
