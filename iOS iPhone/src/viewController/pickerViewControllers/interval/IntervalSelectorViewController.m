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
    infoViewController = [InfoViewController withLocation:0 and:277];
    infoViewController.type = InfoViewControllerInfo;
    infoViewController.text = [[NSString alloc] initWithFormat:@"A picture will be taken every %@ seconds", [[[self.intervalData interval] time] totalTimeInSeconds]];
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
        [self.warningBackround setHidden:false];
    }
    
}

-(void) upperBoundsCheck:(NSInteger)row
             inComponent:(NSInteger)component withPreviousLength:(Time *)time {
    
    
    Time * max = [[self.intervalData duration] time];
    if(![[self.intervalData duration] unlimitedDuration] && [[self time] totalTimeInSeconds] >= [max totalTimeInSeconds]) {
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
        [self.warningBackround setHidden:false];


    }
    

    
}


- (void)viewDidUnload {
    [self setWarningBackround:nil];
    [super viewDidUnload];
}
@end
