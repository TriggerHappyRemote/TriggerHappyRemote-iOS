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




@end
