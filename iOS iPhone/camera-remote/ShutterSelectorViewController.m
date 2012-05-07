//
//  ShutterSelectorViewController.m
//  Trigger Happy, V1.0
//
//  Created by Kevin Harrington on 4/27/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "ShutterSelectorViewController.h"

@implementation ShutterSelectorViewController



-(void) initializeInstructionLabel {
    self.instructionLabel.text = @"shutter selector - auto shutter";
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

-(void) setPickerMode:(PickerMode)state {
    [[self.intervalData shutter] setPickerMode:state];
}

-(PickerMode)getPickerMode {
    return [[self.intervalData shutter] pickerMode];
}

//-----------------------------------------------------------------------
// manually load arrays with only valid values
// shutter length MUST be less than interval
//-----------------------------------------------------------------------

-(void) loadHoursArray {
    // Hours 0-24
    self.hoursValues = [[NSMutableArray alloc] initWithCapacity:24];
    
    int hourMax = [[[self.intervalData interval] time] hours];
    if([[[self.intervalData interval] time] minutes] > 0)
        hourMax++;
    for(int i = 0; i < hourMax; i++) {
        [self.hoursValues addObject:[NSString stringWithFormat:@"%i", i]];
    }
}

-(void) loadMinutesArray {
    // Minutes 0-59
    self.minutesValues = [[NSMutableArray alloc] initWithCapacity:60];
    int minuteMax = [[[self.intervalData interval] time] minutes];
    if([[[self.intervalData interval] time] seconds] > 0)
        minuteMax++;
    for(int i = 0; i < minuteMax; i++) {
        [self.minutesValues addObject:[NSString stringWithFormat:@"%i", i]];
    }
}

-(void) loadSecondsArray {    
    // Seconds 0-59
    self.secondsValues = [[NSMutableArray alloc] initWithCapacity:60];
    for(int i = 0; i < [[[self.intervalData interval] time] seconds]; i++) {
        [self.secondsValues addObject:[NSString stringWithFormat:@"%i", i]];
    }
    
}

-(void) loadSubSecondsArray {
    // need to load subsecond intervals
    //30' -  15'  -  8'  -  4'  -  2' - 0'
    
    self.subSecondsValues = [[NSMutableArray alloc] initWithCapacity:6];
    self.subSecondsValuesNumbers = [[NSMutableArray alloc] initWithCapacity:6];
    
    [self.subSecondsValues addObject:[NSString stringWithFormat:@"0"]];
    [self.subSecondsValues addObject:[NSString stringWithFormat:@"1/30"]];
    [self.subSecondsValues addObject:[NSString stringWithFormat:@"1/15"]];
    [self.subSecondsValues addObject:[NSString stringWithFormat:@"1/8"]];
    [self.subSecondsValues addObject:[NSString stringWithFormat:@"1/4"]];
    [self.subSecondsValues addObject:[NSString stringWithFormat:@"1/2"]];
    
    [self.subSecondsValuesNumbers addObject:[NSNumber numberWithInt:0]];
    [self.subSecondsValuesNumbers addObject:[NSNumber numberWithInt:33]];
    [self.subSecondsValuesNumbers addObject:[NSNumber numberWithInt:67]];
    [self.subSecondsValuesNumbers addObject:[NSNumber numberWithInt:125]];
    [self.subSecondsValuesNumbers addObject:[NSNumber numberWithInt:250]];
    [self.subSecondsValuesNumbers addObject:[NSNumber numberWithInt:500]];
}


@end
