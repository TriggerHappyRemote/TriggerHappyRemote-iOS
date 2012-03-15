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

@synthesize durationPicker, duration;

bool unlimited;

IntervalData *intervalData;

-(void) viewDidLoad {
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];

    
	[durationPicker setDatePickerMode:UIDatePickerModeCountDownTimer];
    
    if([intervalData isUnlimitedDuration]) {
        [duration setSelectedSegmentIndex:0];
        [durationPicker setHidden:[intervalData isUnlimitedDuration]];

    }
    else {
        [duration setSelectedSegmentIndex:1];
        [durationPicker setHidden:[intervalData isUnlimitedDuration]];
    }

    [durationPicker setCountDownDuration:[intervalData getDuration]];
	
}

-(void) viewWillAppear:(BOOL)animated {
    [durationPicker setHidden:[intervalData isUnlimitedDuration]];
    [durationPicker setCountDownDuration:[intervalData getDuration]];
    [[[self navigationController] tabBarController] tabBar].hidden = YES;
}

-(IBAction) toggleSegmentControl {
    NSLog(@"Toggle duration segment control");
    
    [durationPicker setHidden: !durationPicker.isHidden];
    [intervalData setUnlimitedDuration: durationPicker.isHidden];
    
    
}

-(IBAction) changeInDuration {
    NSLog(@"Change in duration");
 	NSTimeInterval durationCountDown = [durationPicker countDownDuration];
    [intervalData setDuration:durationCountDown];
   
}


@end
