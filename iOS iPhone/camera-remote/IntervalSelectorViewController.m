//
//  TimeSelectorIntervalViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntervalSelectorViewController.h"

@implementation IntervalSelectorViewController 


// TODO: remove when done testing inheritance
-(void) loadHoursArray {
    NSLog(@"Hours overloaded");
    
    // Hours 0-12
    self.hoursValues = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 0; i < 12; i++) {
        [self.hoursValues addObject:[NSString stringWithFormat:@"%i", i]];
    }
}

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




@end
