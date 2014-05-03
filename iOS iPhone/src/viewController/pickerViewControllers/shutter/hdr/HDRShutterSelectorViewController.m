//
//  HDRShutterSelectorViewController.m
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

#import "HDRShutterSelectorViewController.h"
#import "IntervalData.h"
#import "InfoViewController.h"
#import "Shutter.h"
#import "Interval.h"
#import "Time.h"

@implementation HDRShutterSelectorViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    if(IDIOM == IPAD)
        infoViewController = [InfoViewController withLocationForPad:82 and:300];
    else
        infoViewController = [InfoViewController withLocationForPhone:0 and:277];    infoViewController.type = InfoViewControllerInfo;
    infoViewController.text = self.infoMessage;
    [self.view addSubview:infoViewController.view];
}

-(void) initializeInstructionLabel {
    //self.instructionLabel.text = @"HDR base shutter auto";
}

-(void) changeHour: (int) hour {
    [[[[[IntervalData getInstance] shutter] hdr] baseShutterSpeed] setHours:hour];
}

-(void) changeMinute: (int) minute {
    [[[[[IntervalData getInstance] shutter] hdr] baseShutterSpeed] setMinutes:minute];
    
}

-(void) changeSecond: (int) second {
    [[[[[IntervalData getInstance] shutter] hdr] baseShutterSpeed] setSeconds:second];
}

-(void) changeMillisecond: (int) millisecond {
    [[[[[IntervalData getInstance] shutter] hdr] baseShutterSpeed] setMilliseconds:millisecond];
}

-(Time *) time {
    return [[[[IntervalData getInstance] shutter] hdr] baseShutterSpeed];
}

-(void) registerSegmentChangeToModel {
    [[[[IntervalData getInstance] shutter] hdr] setBulb:[self.segment selectedSegmentIndex] == 0];
}

-(int) getSegmentIndex { 
    if([[[[IntervalData getInstance] shutter] hdr] bulb]) {
        return 0; // bulb
    }
    else {
        return 1; // auto
    }
}

-(void) setPickerMode:(PickerMode) state {
    [[[[IntervalData getInstance] shutter] hdr ] setPickerMode:state];
    
}

-(PickerMode)getPickerMode {
    return [[[[IntervalData getInstance] shutter] hdr] pickerMode];
}

// for hdr, upper bounds check must sum all exposures
-(void) boundsCheck:(NSInteger)row inComponent:(NSInteger)component withPreviousLength:(Time *)_time {
    Time * max = [[[IntervalData getInstance] interval] time];
    if([[[IntervalData getInstance] interval] intervalEnabled] && [[[[IntervalData getInstance] shutter] hdr] getMaxShutterLength] >= [max totalTimeInSeconds]) {
        [self.picker selectedRowInComponent:0];
        [self.picker selectRow:[_time hours] inComponent:0 animated:false];
        [self.picker selectRow:[_time minutes] inComponent:1 animated:false];
        [self.picker selectRow:[_time seconds] inComponent:2 animated:false];
        [self changeHour:[_time hours]];
        [self changeMinute:[_time minutes]];
        [self changeSecond:[_time seconds]];
                
        infoViewController.type = InfoViewControllerWarning;
        infoViewController.text = self.warningMessage;
    }
    else {
        infoViewController.type = InfoViewControllerInfo;
        infoViewController.text = self.infoMessage;
    }
}

- (NSString *) infoMessage {
    return [[NSString alloc] initWithFormat:@"For each interval %i shots will be taken in %@", [IntervalData getInstance].shutter.hdr.numberOfShots, [[[IntervalData getInstance].shutter getMaxTime] toStringDescriptive]];
}

- (NSString *) warningMessage {
    return @"The cumulation of shutter lengths must be shorter than the interval";
}

@end
