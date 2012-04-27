//
//  ITimeSelectorViewController.m
//  Trigger Happy, V1.0
//
//  Created by Kevin Harrington on 1/17/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "ITimeSelectorViewController.h"
#import "IntervalData.h"
#import "AppDelegate.h"

@implementation ITimeSelectorViewController

@synthesize picker = _picker;

@synthesize secondsValues = _secondsValues;
@synthesize hoursValues = _hoursValues;
@synthesize minutesValues = _minutesValues;

@synthesize hoursLabel, minsLabel, secsLabel;

@synthesize segment, instructionLabel;
@synthesize intervalData = _intervalData;
@synthesize instructionLabelVisible;

- (void)viewWillAppear:(BOOL)animated {
    
    _intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
    
    [self.segment setSelectedSegmentIndex:[self getSegmentIndex]];
    
    [self setPickerVisibility];
    
    [[[self navigationController] tabBarController] tabBar].hidden = YES;
    
    [self initializeInstructionLabel];
    [self loadHoursArray];
    [self loadMinutesArray];
    [self loadSecondsArray];
    [self loadDefaultTime];
    
    // deal with singular hour/minute/seocnd corner case in UILabels
    //  example: 1 /min/ versus 0 || 2-59 /mins/
    if([self time].hours == 1)
        hoursLabel.text = @"hour";
    else
        hoursLabel.text = @"hours";
    
    if([self time].minutes == 1)
        minsLabel.text = @"min";
    else
        minsLabel.text = @"mins";
    
    if([self time].seconds == 1)
        secsLabel.text = @"sec";
    else
        secsLabel.text = @"secs";
}

-(void) initializeInstructionLabel {
    instructionLabelVisible = true;
    instructionLabel.text = @"This is a suber class - off mode";
    [instructionLabel setHidden:true];
}

-(void) loadHoursArray {
    // Hours 0-24
    self.hoursValues = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 0; i < 24; i++) {
        [self.hoursValues addObject:[NSString stringWithFormat:@"%i", i]];
    }

}

-(void) loadMinutesArray {
    // Minutes 0-59
    self.minutesValues = [[NSMutableArray alloc] initWithCapacity:60];
    for(int i = 0; i < 60; i++) {
        [self.minutesValues addObject:[NSString stringWithFormat:@"%i", i]];
    }
}

-(void) loadSecondsArray {
    // Seconds 0-59
    self.secondsValues = [[NSMutableArray alloc] initWithCapacity:60];
    for(int i = 0; i < 60; i++) {
        [self.secondsValues addObject:[NSString stringWithFormat:@"%i", i]];
    }

}

-(void) loadDefaultTime {
    [self.picker selectRow:[[self time] hours] inComponent:0 animated:false];
    [self.picker selectRow:[[self time] minutes] inComponent:1 animated:false];
    [self.picker selectRow:[[self time] seconds] inComponent:2 animated:false];

}


-(void) changeHour: (int) hour {}
-(void) changeMinute: (int) minute {}
-(void) changeSecond: (int) second {}

-(Time *) time {
    // return a dummy time for this super interface
    Time * t = [Time new];
    [t setHours:6];
    [t setMinutes:6];
    [t setSeconds:6];
    return t;
}

// ---------------------------------------------------------------------
// UIPickerView method implementations
// ---------------------------------------------------------------------

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    NSLog(@"comp %i", component);
    switch (component) {
        case 0:
            return [self.hoursValues count];
        case 1:
            return [self.minutesValues count];
        default:
            return [self.secondsValues count];
    }
}

// get the value from the model to load
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [self.hoursValues objectAtIndex:row];
        case 1:
            return [self.minutesValues objectAtIndex:row];
        default:
            return [self.secondsValues objectAtIndex:row];
    }
} 

// set model values when a row is selected in a picker column
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    NSLog(@"selected: row %i comp %i", row, component );
    NSLog(@"Row 1 selected");
    if(component == 0) {
        if(row == 1)
            hoursLabel.text = @"hour";
        else
            hoursLabel.text = @"hours";
        [self changeHour:row];
    }
    else if(component == 1) {
        if(row == 1)
            minsLabel.text = @"min";
        else
            minsLabel.text = @"mins";
        
        [self changeMinute:row];
    }
    else {   
        if(row == 1)
            secsLabel.text = @"sec";
        else
            secsLabel.text = @"secs";
        
        [self changeSecond:row];
    }
    
    Time * currentTime = [self time];
    
    // Make it so time can never go to 00:00:00
    //  If user enters the state of 0h:0m:0s it changes the model & view to 00:00:01
    if((component == 2 && row == 0 && [currentTime minutes] == 0 && [currentTime hours] == 0) ||
       ([currentTime minutes] == 0 && [currentTime hours] == 0 && [currentTime seconds] == 0) ) {
        [self.picker selectRow:1 inComponent:2 animated:false];
        [self changeSecond:1];
    }
    
//    if((component == 2 && row == 0 && [[intervalData interval] minutes] == 0 && [[intervalData interval] hours] == 0) ||
//       ([[intervalData interval] minutes] == 0 && [[intervalData interval] hours] == 0 && [[intervalData interval] seconds] == 0) ) {
//        [_picker selectRow:1 inComponent:2 animated:false];
//        [[intervalData interval] setSeconds:1];
//    }
}

-(IBAction)segmentDidChange {
    NSLog(@"selected segment: %i", [self.segment selectedSegmentIndex]);
    [self setPickerVisibility];
    [self registerSegmentChangeToModel];

}

-(void) setPickerVisibility {
    if([self.segment selectedSegmentIndex] == 0) {
        NSLog(@"hidding picker");
        [self.picker setHidden:false];
        [self.instructionLabel setHidden:true];
    }
    else {
        NSLog(@"showing picker");
        [self.picker setHidden:true];
        [self.instructionLabel setHidden:false];

    }
}

-(void) registerSegmentChangeToModel {}

-(int) getSegmentIndex { return 0;}

-(IBAction)textFieldReturn:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.picker = nil;
}

@end