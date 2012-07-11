//
//  DurationViewController.m
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "DurationViewController.h"
#import "AppDelegate.h"

@implementation DurationViewController

@synthesize durationPicker;
@synthesize duration;

bool unlimited;

IntervalData *intervalData;

-(void) viewDidLoad {
    [super viewDidLoad];
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
	[durationPicker setDatePickerMode:UIDatePickerModeCountDownTimer];

    if([[intervalData shutter] mode] == BRAMP) {
        [duration setHidden:true];
        
    }
    
    if([[intervalData duration] unlimitedDuration]) {
        [duration setSelectedSegmentIndex:0];
        [durationPicker setHidden:true];
        
    } else {
        [duration setSelectedSegmentIndex:1];
        [durationPicker setHidden:false];
    }
    
    infoViewController = [InfoViewController withLocation:0 and:277];
    infoViewController.text =  [[NSString alloc] initWithFormat:@"The entire time lapse duration is %@", [intervalData.duration.time toStringDescriptive]];
    infoViewController.type = InfoViewControllerInfo;
    [self.view addSubview:infoViewController.view];
    
    [durationPicker setCountDownDuration:[[[intervalData duration] time]totalTimeInSeconds]];
}

-(IBAction) toggleSegmentControl {
    [self changeInDuration];
    [durationPicker setHidden:[self.duration selectedSegmentIndex] == 0];
    [[intervalData duration] 
     setUnlimitedDuration:[self.duration selectedSegmentIndex] == 0];
}

-(IBAction) changeInDuration {
    if(durationPicker.countDownDuration <= [[[intervalData interval] time] totalTimeInSeconds]) {
        [durationPicker setCountDownDuration:[[[intervalData interval] time] totalTimeInSeconds]+2];
        [[[intervalData duration] time] setTotalTimeInSeconds:[[[intervalData interval] time] totalTimeInSeconds]+2];
        infoViewController.text =  [[NSString alloc] initWithFormat:@"The entire time lapse duration must be longer than the interval"]; // of %@", [intervalData.interval.time toStringDescriptive]]; 
        infoViewController.type = InfoViewControllerWarning;
    }
    else {
        intervalData.duration.time.totalTimeInSeconds = durationPicker.countDownDuration;
        infoViewController.text =  [[NSString alloc] initWithFormat:@"The entire time lapse duration is %@", [intervalData.duration.time toStringDescriptive]]; 
        infoViewController.type = InfoViewControllerInfo;
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
