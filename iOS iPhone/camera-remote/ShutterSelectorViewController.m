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

@end
