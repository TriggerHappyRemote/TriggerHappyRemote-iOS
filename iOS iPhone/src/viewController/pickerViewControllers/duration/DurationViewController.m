//
//  DurationViewController.m
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
