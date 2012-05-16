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

-(void) lowerBoundsCheck:(NSInteger)row
             inComponent:(NSInteger)component {
    if([[self time] totalTimeInSeconds] <= [[[self.intervalData shutter] getMaxTime] totalTimeInSeconds]) {

        Time * newMax = [Time new];
        [newMax setTotalTimeInSeconds:[[[self.intervalData shutter] getMaxTime] totalTimeInSeconds] + 1];
        [self.picker selectRow:[newMax hours] inComponent:0 animated:false];
        [self.picker selectRow:[newMax minutes] inComponent:1 animated:false];
        [self.picker selectRow:[newMax seconds] inComponent:2 animated:false];
        [self changeHour:[newMax hours]];
        [self changeMinute:[newMax minutes]];
        [self changeSecond:[newMax seconds]];
        
        
        
        
        [self.instructionLabel setText:@"Interval must be longer than the shutter"];
        [self.instructionLabel setHidden:false];
    }
    
}

-(void) upperBoundsCheck:(NSInteger)row
             inComponent:(NSInteger)component {
    
    
    Time * max = [[self.intervalData duration] time];
    if([[self time] totalTimeInSeconds] >= [max totalTimeInSeconds]) {
        Time * newMax = [Time new];
        [newMax setTotalTimeInSeconds:[max totalTimeInSeconds] - 1];
        [self.picker selectRow:[newMax hours] inComponent:0 animated:false];
        [self.picker selectRow:[newMax minutes] inComponent:1 animated:false];
        [self.picker selectRow:[newMax seconds] inComponent:2 animated:false];
        [self changeHour:[newMax hours]];
        [self changeMinute:[newMax minutes]];
        [self changeSecond:[newMax seconds]];
        [self.instructionLabel setText:@"Interval must be shorter than duration"];
        [self.instructionLabel setHidden:false];

    }
    

    
}


@end
