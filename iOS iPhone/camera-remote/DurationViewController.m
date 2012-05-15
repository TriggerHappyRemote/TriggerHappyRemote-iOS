//
//  DurationViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DurationViewController.h"
#import "AppDelegate.h"

@implementation DurationViewController

@synthesize durationPicker;

@synthesize duration;

bool unlimited;

IntervalData *intervalData;

-(void) viewWillAppear:(BOOL)animated {
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];

	[durationPicker setDatePickerMode:UIDatePickerModeCountDownTimer];
    
    if([[intervalData duration] unlimitedDuration]) {
        [duration setSelectedSegmentIndex:0];
        [durationPicker setHidden:true];

    }
    else {
        [duration setSelectedSegmentIndex:1];
        [durationPicker setHidden:false];
    }

    //if([[intervalData interva )
    
    [durationPicker setCountDownDuration:[[[intervalData duration] time]totalTimeInSeconds]];
	
}

-(IBAction) toggleSegmentControl {
    NSLog(@"Toggle duration segment control %i", [self.duration selectedSegmentIndex]);
    
    [durationPicker setHidden:[self.duration selectedSegmentIndex] == 0];
    [[intervalData duration] 
     setUnlimitedDuration:[self.duration selectedSegmentIndex] == 0];
    
    
}

-(IBAction) changeInDuration {
    
 	NSTimeInterval durationCountDown = [durationPicker countDownDuration];
    if(durationCountDown <= [[[intervalData interval] time] totalTimeInSeconds]) {
        [durationPicker setCountDownDuration:[[[intervalData interval] time] totalTimeInSeconds]+2];
        durationCountDown = [[[intervalData interval] time] totalTimeInSeconds]+2;
    }
    
    
    [[[intervalData duration] time] setTotalTimeInSeconds:durationCountDown];
    NSLog(@"Change in duration: %@", [[[intervalData duration] time] toStringDownToSeconds] );
}


@end
