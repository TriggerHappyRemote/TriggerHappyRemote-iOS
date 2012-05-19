//
//  IShutterSelectorViewController.m
//  Trigger-Happy
//
//  Created by Kevin Harrington on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IShutterSelectorViewController.h"

@implementation IShutterSelectorViewController

-(void) viewDidLoad {
    // for lite
    [self.segment setHidden:true];    
}

-(void) upperBoundsCheck:(NSInteger)row
             inComponent:(NSInteger)component {
    Time * max = [[self.intervalData interval] time];
    if([[self.intervalData interval] intervalEnabled] && [[self time] totalTimeInSeconds] >= [max totalTimeInSeconds]) {
        
        Time * newMax = [Time new];
        [newMax setTotalTimeInSeconds:[max totalTimeInSeconds] - 1];
        [self.picker selectRow:[newMax hours] inComponent:0 animated:false];
        [self.picker selectRow:[newMax minutes] inComponent:1 animated:false];
        [self.picker selectRow:[newMax seconds] inComponent:2 animated:false];
        [self changeHour:[newMax hours]];
        [self changeMinute:[newMax minutes]];
        [self changeSecond:[newMax seconds]];
        
        [self.warningBackround setHidden:false];
        [self.instructionLabel setHidden:false];
    }
    
}

@end
