//
//  TimeSelectorIntervalViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntervalSelectorViewController.h"

@implementation IntervalSelectorViewController 

-(void) initializeInstructionLabel {
    self.instructionLabel.text = @"Interval off";
}

-(void) changeHour: (int) hour {
    [[[self.intervalData interval] time] setHours:hour];
}

-(void) changeMinute: (int) minute {
    [[[self.intervalData interval] time] setMinutes:minute];

}

-(void) changeSecond: (int) second {
    [[[self.intervalData interval] time] setSeconds:second];
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





@end
