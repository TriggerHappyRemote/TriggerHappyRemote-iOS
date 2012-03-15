//
//  IntervalViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntervalViewController.h"
#import "IntervalData.h"
#import "AppDelegate.h"

@implementation IntervalViewController;

@synthesize picker, secsValues, hoursValues, hoursLabel, minsLabel, secsLabel;


IntervalData *intervalData;

- (void)viewDidLoad {
    [super viewDidLoad];
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
    
    self.secsValues = [[NSMutableArray alloc] initWithCapacity:61];
    
    for(int i = 0; i < 60; i++) {
        [secsValues addObject:[NSString stringWithFormat:@"%i", i]];
    }
    
    self.hoursValues = [[NSMutableArray alloc] initWithObjects:
                       @"0", @"1", @"2", @"3",
                       @"4", @"5", @"6",
                       @"7", @"8", @"9",
                       @"10", @"11", @"12",
                        nil];
    
    
    [picker selectRow:[intervalData getIntervalHours] inComponent:0 animated:false];
    [picker selectRow:[intervalData getIntervalMinutes] inComponent:1 animated:false];
    [picker selectRow:[intervalData getIntervalSeconds] inComponent:2 animated:false];
    
    if([intervalData getIntervalHours] == 1)
        hoursLabel.text = @"hour";
    else
        hoursLabel.text = @"hours";

    if([intervalData getIntervalMinutes] == 1)
        minsLabel.text = @"min";
    else
        minsLabel.text = @"mins";
    
    if([intervalData getIntervalSeconds] == 1)
        secsLabel.text = @"sec";
    else
        secsLabel.text = @"secs";
}

-(void) viewWillAppear:(BOOL)animated {
    [[[self navigationController] tabBarController] tabBar].hidden = YES;
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

        [intervalData setIntervalHours:row];
    }
    else if(component == 1) {
        if(row == 1)
            minsLabel.text = @"min";
        else
            minsLabel.text = @"mins";

        [intervalData setIntervalMinutes:row];
    }
    else {   
        if(row == 1)
            secsLabel.text = @"sec";
        else
            secsLabel.text = @"secs";
        [intervalData setIntervalSeconds:row];
    }
    
    if((component == 2 && row == 0 && [intervalData getIntervalMinutes] == 0 && [intervalData getIntervalHours] == 0) ||
       ([intervalData getIntervalMinutes] == 0 && [intervalData getIntervalHours] == 0 && [intervalData getIntervalSeconds] == 0) ) {
        [picker selectRow:1 inComponent:2 animated:false];
        [intervalData setIntervalSeconds:1];
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