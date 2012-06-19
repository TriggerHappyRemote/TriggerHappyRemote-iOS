//
//  HDRShutterSelectorViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 4/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HDRShutterSelectorViewController.h"

@implementation HDRShutterSelectorViewController

-(void) initializeInstructionLabel {
    self.instructionLabel.text = @"HDR base shutter auto";
}

-(void) changeHour: (int) hour {
    [[[[self.intervalData shutter] hdr] baseShutterSpeed] setHours:hour];
}

-(void) changeMinute: (int) minute {
    [[[[self.intervalData shutter] hdr] baseShutterSpeed] setMinutes:minute];
    
}

-(void) changeSecond: (int) second {
    [[[[self.intervalData shutter] hdr] baseShutterSpeed] setSeconds:second];
}

-(void) changeMillisecond: (int) millisecond {
    [[[[self.intervalData shutter] hdr] baseShutterSpeed] setMilliseconds:millisecond];

}


-(Time *) time {
    return [[[self.intervalData shutter] hdr] baseShutterSpeed];
}

-(void) registerSegmentChangeToModel {
    [[[self.intervalData shutter] hdr] setBulb:[self.segment selectedSegmentIndex] == 0];
}

-(int) getSegmentIndex { 
    if([[[self.intervalData shutter] hdr] bulb]) {
        NSLog(@"0");
        return 0; // bulb
        
    }
    else {
        NSLog(@"1");
        return 1; // auto
    }
}



-(void) setPickerMode:(PickerMode) state {
    [[[self.intervalData shutter] hdr ] setPickerMode:state];
    
}

-(PickerMode)getPickerMode {
    return [[[self.intervalData shutter] hdr] pickerMode];
}

// for hdr, upper bounds check must sum all exposures
-(void) upperBoundsCheck:(NSInteger)row inComponent:(NSInteger)component withPreviousLength:(Time *)_time {
    Time * max = [[self.intervalData interval] time];
    if([[self.intervalData interval] intervalEnabled] && [[[self.intervalData shutter] hdr] getMaxShutterLength] >= [max totalTimeInSeconds]) {
        
        [self.picker selectedRowInComponent:0];
        
        [self.picker selectRow:[_time hours] inComponent:0 animated:false];
        [self.picker selectRow:[_time minutes] inComponent:1 animated:false];
        [self.picker selectRow:[_time seconds] inComponent:2 animated:false];
        [self changeHour:[_time hours]];
        [self changeMinute:[_time minutes]];
        [self changeSecond:[_time seconds]];
        
        [self.warningBackround setHidden:false];
        [self.instructionLabel setHidden:false];
    }
}



@end
