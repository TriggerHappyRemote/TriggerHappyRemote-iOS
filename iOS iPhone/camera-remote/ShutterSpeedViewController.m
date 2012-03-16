//
//  IntervalViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShutterSpeedViewController.h"
#import "IntervalData.h"
#import "AppDelegate.h"

@implementation ShutterSpeedViewController;

@synthesize picker, secsValues, hoursValues, hoursLabel, minsLabel, secsLabel, instructionLabel, autoBulbSegment;

IntervalData *intervalData;

- (void)viewDidLoad {
    [super viewDidLoad];
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
    
    
    
    if([intervalData autoShutter]) {
        [autoBulbSegment setSelectedSegmentIndex:0];
        [picker setHidden:true];
        [hoursLabel setHidden:true];
        [minsLabel setHidden:true];
        [secsLabel setHidden:true];
        [instructionLabel setHidden:false];
    }
    else {
        [autoBulbSegment setSelectedSegmentIndex:1];
        [picker setHidden:false];
        [hoursLabel setHidden:false];
        [minsLabel setHidden:false];
        [secsLabel setHidden:false];
        [instructionLabel setHidden:true];

    }
    
    self.secsValues = [[NSMutableArray alloc] initWithCapacity:76];
    
    [secsValues addObject:[NSString stringWithFormat:@"0"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/60"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/50"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/40"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/30"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/25"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/20"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/15"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/13"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/10"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/8"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/6"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/5"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/4"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/3"]];
    [secsValues addObject:[NSString stringWithFormat:@"1/2"]];

    
    for(int i = 0; i < 60; i++) {
        [secsValues addObject:[NSString stringWithFormat:@"%i", i]];
    }
    
    self.hoursValues = [[NSMutableArray alloc] initWithObjects:
                        @"0", @"1", @"2", @"3",
                        @"4", @"5", @"6",
                        @"7", @"8", @"9",
                        @"10", @"11", @"12",
                        nil];
    
    [picker selectRow:[[intervalData shutterSpeed] hours] inComponent:0 animated:false];
    [picker selectRow:[[intervalData shutterSpeed] minutes] inComponent:1 animated:false];
    [picker selectRow:[[intervalData shutterSpeed] seconds] inComponent:2 animated:false];
    
    if([[intervalData shutterSpeed] hours] == 1)
        hoursLabel.text = @"hour";
    else
        hoursLabel.text = @"hours";
    
    if([[intervalData shutterSpeed] minutes] == 1)
        minsLabel.text = @"min";
    else
        minsLabel.text = @"mins";
    
    if([[intervalData shutterSpeed] seconds] == 1)
        secsLabel.text = @"sec";
    else
        secsLabel.text = @"secs";
}

- (void) viewDidAppear:(BOOL)animated {

    [[[self navigationController] tabBarController] tabBar].hidden = YES;
}

-(IBAction) toggleSegmentControl { 
    bool state = !picker.isHidden;
    [picker setHidden:state];
    [intervalData setAutoShutter:state];
    [picker setHidden:state];
    [hoursLabel setHidden:state];
    [minsLabel setHidden:state];
    [secsLabel setHidden:state];
    [instructionLabel setHidden:!state];
}


#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    NSLog(@"comp %i", component);
    switch (component) {
        case 0:
            return [hoursValues count];
        default:
            return [secsValues count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
            return [hoursValues objectAtIndex:row];
        default:
            return [secsValues objectAtIndex:row];
    }
} 

#pragma mark -
#pragma mark PickerView Delegate
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
        
        [[intervalData interval] setHours:row];
    }
    else if(component == 1) {
        if(row == 1)
            minsLabel.text = @"min";
        else
            minsLabel.text = @"mins";
        
        [[intervalData interval] setMinutes:row];
    }
    else {   
        if(row == 1)
            secsLabel.text = @"sec";
        else
            secsLabel.text = @"secs";
        [[intervalData interval] setSeconds:row];
        
    }
    
    if((component == 2 && row == 0 && [[intervalData interval] minutes] == 0 && [[intervalData interval] hours] == 0) ||
       ([[intervalData interval] minutes] == 0 && [[intervalData interval] hours] == 0 && [[intervalData interval] seconds] == 0) ) {
        [picker selectRow:1 inComponent:2 animated:false];
        [[intervalData interval] setSeconds:1];
    }
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.picker = nil;
}

@end