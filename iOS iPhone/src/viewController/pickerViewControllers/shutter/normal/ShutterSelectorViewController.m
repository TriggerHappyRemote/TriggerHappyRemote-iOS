//
//  ShutterSelectorViewController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
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
