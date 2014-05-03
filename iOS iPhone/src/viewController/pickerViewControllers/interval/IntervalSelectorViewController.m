//
//  TimeSelectorIntervalViewController.m
//  Copyright (c) 2014 Kevin Harrington
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  Created by Kevin Harrington on 1/9/12.
//  
//

#import "IntervalSelectorViewController.h"
#import "IntervalData.h"
#import "Time.h"
#import "InfoViewController.h"
#import "Shutter.h"
#import "Interval.h"
#import "IntervalDuration.h"

@implementation IntervalSelectorViewController 

int hourOffSet;
int minuteOffSet;
int secondOffSet;

-(void) viewDidLoad {
    [super viewDidLoad];
    if(IDIOM == IPAD)
        infoViewController = [InfoViewController withLocationForPad:82 and:300];
    else
        infoViewController = [InfoViewController withLocationForPhone:0 and:277];
    
    infoViewController.type = InfoViewControllerInfo;
    [infoViewController setText:[[NSString alloc] initWithFormat:@"A photo will be taken every %@", [[self time] toStringDescriptive]]];
    [self.view addSubview:infoViewController.view];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerSegmentChangeToModel];
}

-(void) initializeInstructionLabel {
    //self.instructionLabel.text = @"Interval off";
}

-(void) changeHour: (int) hour {
    [[[[IntervalData getInstance] interval] time] setHours:hour+hourOffSet];
}

-(void) changeMinute: (int) minute {
    [[[[IntervalData getInstance] interval] time] setMinutes:minute+minuteOffSet];

}

-(void) changeSecond: (int) second {
    [[[[IntervalData getInstance] interval] time] setSeconds:second+secondOffSet];
}

-(Time *) time {
    return [[[IntervalData getInstance] interval] time];
}

-(void) registerSegmentChangeToModel {
    if(self.segment.selectedSegmentIndex == 0) { // on
        infoViewController.text = [[NSString alloc] initWithFormat:@"A photo will be taken every %@", [[self time] toStringDescriptive]];
        if(IDIOM != IPAD) {
            infoViewController.position = CGPointMake(0, 277);
        }
    } else { // off
        // OVERRRIDING caller in super class:
        infoViewController.hidden = NO;
        infoViewController.text = @"Only one photo will be taken";
        if(IDIOM != IPAD) {
            infoViewController.position = CGPointMake(0, 50);
        }
        
    }
    [[[IntervalData getInstance] interval] setIntervalEnabled:[self.segment selectedSegmentIndex] == 0];
}

-(int) getSegmentIndex { 
    if([[[IntervalData getInstance] interval] intervalEnabled]) {
        return 0; // on
    }
    else {
        return 1; // off
    }
}

-(void) setPickerMode:(PickerMode)state {
    [[[IntervalData getInstance] interval] setPickerMode:state];
}

-(PickerMode)getPickerMode {
    return [[[IntervalData getInstance] interval] pickerMode];
}

-(void) loadHoursArray {
    // Hours 0-24
    self.hoursValues = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 0; i < 23; i++) {
        [self.hoursValues addObject:[NSString stringWithFormat:@"%i", i]];
    }
}

/* Upper then lower called by super class */
-(void) boundsCheck:(NSInteger)row inComponent:(NSInteger)component withPreviousLength:(Time *)time {
    
    Time * max = [[[IntervalData getInstance] duration] time];
    
    if(![[[IntervalData getInstance] duration] unlimitedDuration] && [[self time] totalTimeInSeconds] >= [max totalTimeInSeconds]) {
        // upper bounds off
        Time * newMax = [Time new];
        [newMax setTotalTimeInSeconds:[max totalTimeInSeconds] - 1];
        [self.picker selectRow:[newMax hours] inComponent:0 animated:false];
        [self.picker selectRow:[newMax minutes] inComponent:1 animated:false];
        [self.picker selectRow:[newMax seconds] inComponent:2 animated:false];
        [self changeHour:[newMax hours]];
        [self changeMinute:[newMax minutes]];
        [self changeSecond:[newMax seconds]];
        
        [infoViewController setText:[[NSString alloc] initWithFormat:@"Interval must be shorter than the duration of %@", [[[[IntervalData getInstance] duration] time] toStringDescriptive]]];
        [infoViewController setType:InfoViewControllerWarning];
    }
    else if([[self time] totalTimeInSeconds] <= [[[[IntervalData getInstance] shutter] getMaxTime] totalTimeInSeconds]) {
        // lower bounds off
        Time * newMax = [Time new];
        [newMax setTotalTimeInSeconds:[[[[IntervalData getInstance] shutter] getMaxTime] totalTimeInSeconds] + 1];
        [self.picker selectRow:[newMax hours] inComponent:0 animated:false];
        [self.picker selectRow:[newMax minutes] inComponent:1 animated:false];
        [self.picker selectRow:[newMax seconds] inComponent:2 animated:false];
        [self changeHour:[newMax hours]];
        [self changeMinute:[newMax minutes]];
        [self changeSecond:[newMax seconds]];

        [infoViewController setText:[[NSString alloc] initWithFormat:@"Interval must be longer than the shutter of %@", [[[[IntervalData getInstance] shutter] getMaxTime] toStringDescriptive]]];
        [infoViewController setType:InfoViewControllerWarning];
    }
    else {
        // in bounds
        [infoViewController setText:[[NSString alloc] initWithFormat:@"A photo will be taken every %@", [[self time] toStringDescriptive]]];
        
        [infoViewController setType:InfoViewControllerInfo];
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
