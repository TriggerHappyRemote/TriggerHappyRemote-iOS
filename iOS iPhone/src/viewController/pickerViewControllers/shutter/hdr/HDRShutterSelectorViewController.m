//
//  HDRShutterSelectorViewController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
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
    [[[[self.intervalData shutter] hdr] baseShutterSpeed] setHours:hour];
}

-(void) changeMinute: (int) minute {
    [[[[self.intervalData shutter] hdr] baseShutterSpeed] setMinutes:minute];
    
}

-(void) changeSecond: (int) second {
    [[[[self.intervalData shutter] hdr] baseShutterSpeed] setSeconds:second];
}

-(void) changeMillisecond: (int) millisecond {
    [[[[self.intervalData shutter] hdr] baseShutterSpeed] setMilliseconds:millisecond];

}


-(Time *) time {
    return [[[self.intervalData shutter] hdr] baseShutterSpeed];
}

-(void) registerSegmentChangeToModel {
    [[[self.intervalData shutter] hdr] setBulb:[self.segment selectedSegmentIndex] == 0];
}

-(int) getSegmentIndex { 
    if([[[self.intervalData shutter] hdr] bulb]) {
        NSLog(@"0");
        return 0; // bulb
        
    }
    else {
        NSLog(@"1");
        return 1; // auto
    }
}

-(void) setPickerMode:(PickerMode) state {
    [[[self.intervalData shutter] hdr ] setPickerMode:state];
    
}

-(PickerMode)getPickerMode {
    return [[[self.intervalData shutter] hdr] pickerMode];
}

// for hdr, upper bounds check must sum all exposures
-(void) boundsCheck:(NSInteger)row inComponent:(NSInteger)component withPreviousLength:(Time *)_time {
    Time * max = [[self.intervalData interval] time];
    if([[self.intervalData interval] intervalEnabled] && [[[self.intervalData shutter] hdr] getMaxShutterLength] >= [max totalTimeInSeconds]) {
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
    return [[NSString alloc] initWithFormat:@"For each interval %i shots will be taken in %@", self.intervalData.shutter.hdr.numberOfShots, [[self.intervalData.shutter getMaxTime] toStringDescriptive]];
}

- (NSString *) warningMessage {
    return @"The cumulation of shutter lengths must be shorter than the interval";
}



@end
