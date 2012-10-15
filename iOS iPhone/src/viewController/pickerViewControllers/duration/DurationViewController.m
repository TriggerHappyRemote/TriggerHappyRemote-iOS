//
//  DurationViewController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "DurationViewController.h"
#import "AppDelegate.h"
#import "IntervalData.h"
#import "InfoViewController.h"
#import "Interval.h"
#import "IntervalDuration.h"
#import "Shutter.h"

@implementation DurationViewController

@synthesize durationPicker;
@synthesize duration;

bool unlimited;

-(void) viewDidLoad {
    [super viewDidLoad];
	[durationPicker setDatePickerMode:UIDatePickerModeCountDownTimer];

    if([[[IntervalData getInstance] shutter] mode] == BRAMP) {
        [duration setHidden:true];
        
    }
    
    if([[[IntervalData getInstance] duration] unlimitedDuration]) {
        [duration setSelectedSegmentIndex:0];
        [durationPicker setHidden:true];
        
    } else {
        [duration setSelectedSegmentIndex:1];
        [durationPicker setHidden:false];
    }
    
    if(IDIOM == IPAD)
        infoViewController = [InfoViewController withLocationForPad:82 and:300];
    else
        infoViewController = [InfoViewController withLocationForPhone:0 and:277];
        
    infoViewController.hidden = (self.duration.selectedSegmentIndex == 0);
    infoViewController.text =  [[NSString alloc] initWithFormat:@"The entire time lapse duration is %@", [[IntervalData getInstance].duration.time toStringDescriptive]];
    infoViewController.type = InfoViewControllerInfo;
    [self.view addSubview:infoViewController.view];
    
    [durationPicker setCountDownDuration:[[[[IntervalData getInstance] duration] time]totalTimeInSeconds]];
}

-(IBAction) toggleSegmentControl {
    [self changeInDuration];
    [durationPicker setHidden:[self.duration selectedSegmentIndex] == 0];
    [[[IntervalData getInstance] duration] 
     setUnlimitedDuration:[self.duration selectedSegmentIndex] == 0];
    infoViewController.hidden = (self.duration.selectedSegmentIndex == 0);
}

-(IBAction) changeInDuration {
    if(durationPicker.countDownDuration <= [[[[IntervalData getInstance] interval] time] totalTimeInSeconds]) {
        [durationPicker setCountDownDuration:[[[[IntervalData getInstance] interval] time] totalTimeInSeconds]+60];
        [[[[IntervalData getInstance] duration] time] setTotalTimeInSeconds:[[[[IntervalData getInstance] interval] time] totalTimeInSeconds]+60];
        infoViewController.text =  [[NSString alloc] initWithFormat:@"The entire time lapse duration must be longer than the interval"]; // of %@", [intervalData.interval.time toStringDescriptive]]; 
        infoViewController.type = InfoViewControllerWarning;
    }
    else {
        [IntervalData getInstance].duration.time.totalTimeInSeconds = durationPicker.countDownDuration;
        infoViewController.text =  [[NSString alloc] initWithFormat:@"The entire time lapse duration is %@", [[IntervalData getInstance].duration.time toStringDescriptive]]; 
        infoViewController.type = InfoViewControllerInfo;
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
