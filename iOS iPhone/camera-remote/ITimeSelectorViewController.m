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

@interface ITimeSelectorViewController()
-(void)loadLabels;
@end

@implementation ITimeSelectorViewController

@synthesize picker = _picker;

@synthesize secondsValues = _secondsValues;

@synthesize label_0, label_1, label_2;

@synthesize segment, instructionLabel;
@synthesize intervalData = _intervalData;
@synthesize instructionLabelVisible;
@synthesize secondSubSecondSegment;

@synthesize hoursValues = _hoursValues;
@synthesize minutesValues = _minutesValues;
@synthesize subSecondsValues = _subSecondValues;
@synthesize subSecondsValuesNumbers = _subSecondsValuesNumbers;

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
    [self loadSubSecondsArray];
    
    [self loadLabels];
    
    [self.secondSubSecondSegment setSelectedSegmentIndex:[self getPickerMode]];
    [self secondSubSecondSegmentChange];
}

//private to this class
-(void) loadLabels {
    // deal with singular hour/minute/seocnd corner case in UILabels
    //  example: 1 /min/ versus 0 || 2-59 /mins/
    
    // labels 0 | 1 | 2
    if(self.getPickerMode == SECONDS) {
        if([self time].hours == 1)
            label_0.text = @"hour";
        else
            label_0.text = @"hours";
        
        if([self time].minutes == 1)
            label_1.text = @"min";
        else
            label_1.text = @"mins";
        
        if([self time].seconds == 1)
            label_2.text = @"sec";
        else
            label_2.text = @"secs";
    }
    if(self.getPickerMode == SUBSECONDS) {
        if([self time].minutes == 1)
            label_0.text = @"min";
        else
            label_0.text = @"mins";
        
        if([self time].seconds == 1)
            label_1.text = @"sec";
        else
            label_1.text = @"secs";
        
        if([self time].milliseconds == 1)
            label_2.text = @"s";
        else
            label_2.text = @"ms";
    }
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

-(void) loadSubSecondsArray {
    // need to load subsecond intervals
    //30' -  15'  -  8'  -  4'  -  2' - 0'
    
    self.subSecondsValues = [[NSMutableArray alloc] initWithCapacity:6];
    self.subSecondsValuesNumbers = [[NSMutableArray alloc] initWithCapacity:6];
    
    [self.subSecondsValues addObject:[NSString stringWithFormat:@"0"]];
    [self.subSecondsValues addObject:[NSString stringWithFormat:@"1/30"]];
    [self.subSecondsValues addObject:[NSString stringWithFormat:@"1/15"]];
    [self.subSecondsValues addObject:[NSString stringWithFormat:@"1/8"]];
    [self.subSecondsValues addObject:[NSString stringWithFormat:@"1/4"]];
    [self.subSecondsValues addObject:[NSString stringWithFormat:@"1/2"]];
    
    [self.subSecondsValuesNumbers addObject:[NSNumber numberWithInt:0]];
    [self.subSecondsValuesNumbers addObject:[NSNumber numberWithInt:33]];
    [self.subSecondsValuesNumbers addObject:[NSNumber numberWithInt:67]];
    [self.subSecondsValuesNumbers addObject:[NSNumber numberWithInt:125]];
    [self.subSecondsValuesNumbers addObject:[NSNumber numberWithInt:250]];
    [self.subSecondsValuesNumbers addObject:[NSNumber numberWithInt:500]];
}

// default time must not be subseconds
-(void) loadDefaultTime {
    
    if(self.getPickerMode == 0) {
        [self.picker selectRow:[[self time] hours] inComponent:0 animated:false];
        [self.picker selectRow:[[self time] minutes] inComponent:1 animated:false];
        [self.picker selectRow:[[self time] seconds] inComponent:2 animated:false];
    }
    else {
        [self.picker selectRow:[[self time] minutes] inComponent:0 animated:false];
        [self.picker selectRow:[[self time] seconds] inComponent:1 animated:false];
        
        int milliseconds = [[self time] milliseconds];
        switch (milliseconds) {
            case 0:
                [self.picker selectRow:0 inComponent:2 animated:false];
                break;
            case 33:
                [self.picker selectRow:1 inComponent:2 animated:false];
                break;
            case 67:
                [self.picker selectRow:2 inComponent:2 animated:false];
                break;
            case 125:
                [self.picker selectRow:3 inComponent:2 animated:false];
                break;
            case 250:
                [self.picker selectRow:4 inComponent:2 animated:false];
                break;
            case 500:
                [self.picker selectRow:5 inComponent:2 animated:false];
                break;
            default:
                [self.picker selectRow:4 inComponent:2 animated:false];
                break;
        }
    }
}


-(void) changeHour: (int) hour {}
-(void) changeMinute: (int) minute {}
-(void) changeSecond: (int) second {}
-(void) changeMillisecond: (int) millisecond {}

-(Time *) time {
    // return a dummy time for this super interface
    Time * t = [Time new];
    [t setHours:6];
    [t setMinutes:6];
    [t setSeconds:6];
    return t;
}

-(IBAction)secondSubSecondSegmentChange {
    NSLog(@"Cur val: %i", secondSubSecondSegment.selectedSegmentIndex);
    [self setPickerMode:secondSubSecondSegment.selectedSegmentIndex];
    [self.picker reloadAllComponents];
    [self loadLabels];
    [self loadDefaultTime];
    
    if(self.getPickerMode == SECONDS) {
        [self changeMillisecond:0];
    }
    else {
        [self changeHour:0];
    }
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
            if(self.getPickerMode == SECONDS)
                return [self.hoursValues count];
            return [self.minutesValues count];
        case 1:
            if(self.getPickerMode == SECONDS)
                return [self.minutesValues count];
            return [self.secondsValues count];
        default:
            if(self.getPickerMode == SECONDS)
                return [self.secondsValues count];
            return [self.subSecondsValues count]; 
    }
}

// get the value from the model to load
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            if(self.getPickerMode == SECONDS)
                return [self.hoursValues objectAtIndex:row];
            return [self.minutesValues objectAtIndex:row];
        case 1:
            if(self.getPickerMode == SECONDS)
                return [self.minutesValues objectAtIndex:row];
            return [self.secondsValues objectAtIndex:row];
        default:
            if(self.getPickerMode == SECONDS)
                return [self.secondsValues objectAtIndex:row];
            return [self.subSecondsValues objectAtIndex:row];
    }
} 


// set model values when a row is selected in a picker column
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    NSLog(@"selected: row %i comp %i", row, component );
    NSLog(@"Row 1 selected");
    if(component == 0) {
        if(self.getPickerMode == SECONDS)
            [self changeHour:row];
        else
            [self changeMinute:row];
    }
    else if(component == 1) {
        if(self.getPickerMode == SECONDS)
            [self changeMinute:row];
        else
            [self changeSecond:row];
        
    }
    else {
        if(self.getPickerMode == SECONDS)
            [self changeSecond:row];
        else {
            [self changeMillisecond:[[self.subSecondsValuesNumbers objectAtIndex:row] intValue]];
        }
    }
    
    [self loadLabels];
    
    Time * currentTime = [self time];
    
    // Make it so time can never go to 00:00:00
    //  If user enters the state of 0h:0m:0s it changes the model & view to 00:00:01
    if(self.getPickerMode == SECONDS) {
        if((component == 2 && row == 0 && [currentTime minutes] == 0 && [currentTime hours] == 0) ||
         ([currentTime minutes] == 0 && [currentTime hours] == 0 && [currentTime seconds] == 0) ) {
            [self.picker selectRow:1 inComponent:2 animated:false];
            [self changeSecond:1];
         }
    }
    else {
        if((component == 2 && row == 0 && [currentTime minutes] == 0 && [currentTime seconds] == 0) ||
           ([currentTime seconds] == 0 && [currentTime minutes] == 0 && [currentTime milliseconds] == 0) ) {
            [self.picker selectRow:1 inComponent:2 animated:false];
            [self changeMillisecond:[[self.subSecondsValuesNumbers objectAtIndex:1] intValue]];
        }    
    }
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

-(void) setPickerMode: (PickerMode) state {}

-(PickerMode) getPickerMode {}

- (void)viewDidUnload {
    [self setSecondSubSecondSegment:nil];
    [super viewDidUnload];
    self.picker = nil;
}

@end