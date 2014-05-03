//
//  TimeBetweenShotsViewController.m
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
//  Created by Kevin Harrington on 9/20/12.
//
//

#import "TimeBetweenShotsViewController.h"
#include "IntervalData.h"
#include "Shutter.h"
#include "Interval.h"
#include "HDR.h"

#define MAXVAL 2.0
#define MINVAL .1

@interface TimeBetweenShotsViewController ()

@end

@implementation TimeBetweenShotsViewController

-(void) viewWillAppear:(BOOL)animated {
    timeSlider.value = ([IntervalData getInstance].shutter.hdr.shutterGap  - MINVAL) / (MAXVAL-MINVAL);
    [self timeValueDidChange:self];
    info.text = @"This is the amount of time between each image in an exposure bracket. This time may need to be increased or decrease depending upon the frames per second of the camera.";
}

- (IBAction)timeValueDidChange:(id)sender {
    [[IntervalData getInstance].shutter.hdr maxTimeBetweenShots];
    [IntervalData getInstance].shutter.hdr.shutterGap = (timeSlider.value * (MAXVAL-MINVAL)) + MINVAL;
    time.text = [[NSString alloc] initWithFormat:@"%.02f Seconds", [IntervalData getInstance].shutter.hdr.shutterGap];
    ;
    
    // enforce interval longer than shutter:
    NSTimeInterval totalShutter = [[IntervalData getInstance].shutter.hdr getMaxShutterLength];
    NSTimeInterval intervalLength = [IntervalData getInstance].interval.time.totalTimeInSeconds;
    if([IntervalData getInstance].interval.intervalEnabled && totalShutter >= intervalLength) {        
        timeSlider.value = ([[IntervalData getInstance].shutter.hdr maxTimeBetweenShots]- MINVAL) / (MAXVAL-MINVAL);
        
        [self timeValueDidChange:self];
        info.text = @"Increase the interval of the time lapse to increase the time between each shot. To do that, nagivate back to HDR then to Time Lapse and select Interval";
    } else {
        info.text = @"This is the amount of time between each image in an exposure bracket. This time may need to be increased or decreased depending upon the frames per second of the camera.";
        sliderValuePrevious = timeSlider.value;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    time = nil;
    timeSlider = nil;
    info = nil;
    [super viewDidUnload];
}



@end
