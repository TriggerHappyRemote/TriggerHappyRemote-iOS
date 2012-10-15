//
//  ITimeSelectorViewController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "ITimeSelectorViewController.h"
#import "IntervalData.h"
#import "AppDelegate.h"
#import "Time.h"
#import "InfoViewController.h"

@interface ITimeSelectorViewController(internal)
-(void)loadLabels;
-(void) zeroCheck:(NSInteger)row inComponent:(NSInteger)component;// TODO: remove

-(bool) shouldZeroCheck;
-(void) loadDefaultTime;
-(void) boundsCheck:(NSInteger)row inComponent:(NSInteger)component withPreviousLength:(Time *)time;


-(void) loadHoursArray;
-(void) loadMinutesArray;
-(void) loadSecondsArray;
-(void) loadSubSecondsArray;



// Delegate to load time from a model
-(IBAction) segmentDidChange;
-(void) setPickerVisibility;
-(void) registerSegmentChangeToModel;
-(int) getSegmentIndex;
-(IBAction)secondSubSecondSegmentChange;

// delegates to set and get picker state
-(void) setPickerMode: (PickerMode) state;
-(PickerMode) getPickerMode;

@end

@implementation ITimeSelectorViewController

@synthesize picker = _picker;

@synthesize secondsValues = _secondsValues;

@synthesize label_0, label_1, label_2;

@synthesize segment;
@synthesize secondSubSecondSegment;

@synthesize hoursValues = _hoursValues;
@synthesize minutesValues = _minutesValues;
//@synthesize subSecondsValues = _subSecondValues;
@synthesize subSecondsValuesNumbers = _subSecondsValuesNumbers;


-(void) viewDidLoad {
    [self.segment setSelectedSegmentIndex:[self getSegmentIndex]];
    
    [self setPickerVisibility];
    
    [[[self navigationController] tabBarController] tabBar].hidden = YES;
    
    [self loadHoursArray];
    [self loadMinutesArray];
    [self loadSecondsArray];
    [self loadDefaultTime];
    [self loadSubSecondsArray];
    
    [self loadLabels];
    
    
    [self.secondSubSecondSegment setSelectedSegmentIndex:[self getPickerMode]];
    [self secondSubSecondSegmentChange];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    // TODO remove
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
        
        if([self time].milliseconds == 0)
            label_2.text = @"ms";
        else
            label_2.text = @"ms";
    }
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
    self.subSecondsValuesNumbers = [[NSMutableArray alloc] initWithCapacity:20];
    for(int i = 0; i <= 19; i++) {
        [self.subSecondsValuesNumbers addObject:[NSString stringWithFormat:@"%i", 50*i]];
    }
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
    [self setPickerMode:secondSubSecondSegment.selectedSegmentIndex];
    [self loadLabels];
    [self loadDefaultTime];
    
    if(self.getPickerMode == SECONDS) {
        [self changeMillisecond:0];
        if([[self time] totalTimeInSeconds] < 1.0) {
            [self zeroCheck:0 inComponent:2];
        }
    }
    else {
        [self changeHour:0];
    }
    [self.picker reloadAllComponents];
}

// ---------------------------------------------------------------------
// UIPickerView method implementations
// ---------------------------------------------------------------------

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {

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
            return [self.subSecondsValuesNumbers count];
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
            return [self.subSecondsValuesNumbers objectAtIndex:row];
    }
} 


// set model values when a row is selected in a picker column
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    Time * previousLength = [[Time alloc] initWithTotalTimeInSeconds:[[self time] totalTimeInSeconds]];
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
    
        // TODO set instuction label to info
    
    [self loadLabels];
    [self zeroCheck:row inComponent:component];
    [self boundsCheck:row inComponent:component withPreviousLength:previousLength];
}

-(void) boundsCheck:(NSInteger)row inComponent:(NSInteger)component withPreviousLength:(Time *)time {/* overridden in subclass */}

-(void) zeroCheck:(NSInteger)row inComponent:(NSInteger)component {
     if([self shouldZeroCheck]) {
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
}
       
-(bool) shouldZeroCheck {
    // used with shutter subseconds
    return true;
}


-(IBAction)segmentDidChange {
    [infoViewController setHidden:segment.selectedSegmentIndex==1];
    [self setPickerVisibility];
    [self registerSegmentChangeToModel];
}

-(void) setPickerVisibility {
    if([self.segment selectedSegmentIndex] == 0) {
        [self.picker setHidden:false];
        [self.secondSubSecondSegment setHidden:false];
    }
    else {
        [self.picker setHidden:true];
        [self.secondSubSecondSegment setHidden:true];
    }
}

-(void) registerSegmentChangeToModel {}

-(int) getSegmentIndex {return 0;}

-(IBAction)textFieldReturn:(id)sender {
    [sender resignFirstResponder];
}

-(void) setPickerMode: (PickerMode) state {}

-(PickerMode) getPickerMode {
    return SECONDS;
}

- (void)viewDidUnload {
    [self setSecondSubSecondSegment:nil];
    [super viewDidUnload];
    self.picker = nil;
    infoViewController = nil;
}

@end