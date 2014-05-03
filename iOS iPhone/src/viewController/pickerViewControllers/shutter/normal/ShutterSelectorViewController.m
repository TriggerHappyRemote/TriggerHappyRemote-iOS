//
//  ShutterSelectorViewController.m
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

#import "ShutterSelectorViewController.h"
#import "IntervalData.h"
#import "InfoViewController.h"
#import "Shutter.h"
#import "Time.h"
#import "Interval.h"

@implementation ShutterSelectorViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    if(IDIOM == IPAD)
        infoViewController = [InfoViewController withLocationForPad:82 and:300];
    else
        infoViewController = [InfoViewController withLocationForPhone:0 and:295];
    infoViewController.type = InfoViewControllerInfo;
    [infoViewController setText:self.infoMessage];
    [self.view addSubview:infoViewController.view];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.segment.selectedSegmentIndex) { // auto
        infoViewController.position = CGPointMake(0, 32);
        infoViewController.hidden = NO;
        infoViewController.text = @"Put camera in single shot mode, and turn off auto focus";
    } else { // manual
        infoViewController.position = CGPointMake(0, 282);
        infoViewController.text = [self infoMessage];
    }
}

-(void) initializeInstructionLabel {
    //self.instructionLabel.text = @"shutter selector - auto shutter";
}

-(void) changeHour: (int) hour {
    [[[[IntervalData getInstance] shutter] startLength] setHours:hour];
}

-(void) changeMinute: (int) minute {
    [[[[IntervalData getInstance] shutter] startLength] setMinutes:minute];
    
}

-(void) changeSecond: (int) second {
    [[[[IntervalData getInstance] shutter] startLength] setSeconds:second];
}

-(void) changeMillisecond:(int)millisecond {
    [[[[IntervalData getInstance] shutter] startLength] setMilliseconds:millisecond];
}

-(Time *) time {
    return [[[IntervalData getInstance] shutter] startLength];
}

-(void) registerSegmentChangeToModel {
    if(self.segment.selectedSegmentIndex) { // auto
        infoViewController.position = CGPointMake(0, 32);
        infoViewController.hidden = NO;
        infoViewController.text = @"Put camera in single shot mode, and turn off auto focus";
    } else { // manual
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Bulb Mode Required in Manual" message:@"Please put your camera in bulb." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        infoViewController.position = CGPointMake(0, 282);
        infoViewController.text = [self infoMessage];
    }
    [[[IntervalData getInstance] shutter] setBulbMode:[self.segment selectedSegmentIndex] == 0];
}

-(int) getSegmentIndex { 
    if([[[IntervalData getInstance] shutter] bulbMode]) {
        return 0; // bulb
    }
    else {
        return 1; // auto
    }
}

-(void) setPickerMode:(PickerMode) state {
    [[[IntervalData getInstance] shutter] setPickerMode:state];
    
}

-(PickerMode)getPickerMode {
    return [[[IntervalData getInstance] shutter] pickerMode];
}

- (NSString *) infoMessage {
    return [[NSString alloc] initWithFormat:@"Each photo will have a %@shutter length", [[self time] toStringDescriptive]];
}

- (NSString *) warningMessage {
    return [[NSString alloc] initWithFormat:@"Shutter must be shorter than the %@ interval", [[IntervalData getInstance].interval.time toStringDescriptive]];
}

@end
