//
//  HDREVViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HDREVViewController.h"
#include "IntervalData.h"
#include "AppDelegate.h"

@implementation HDREVViewController

@synthesize picker;


IntervalData *intervalData;


//base 3
// due to Apple's fail, we can map anything
const int evValuesThirdsSize = 10;
const double evModelValues[evValuesThirdsSize] = {.333,.666,1,2,3,4,5,6,7,8 };


NSString * evValuesThirds[evValuesThirdsSize] = {@"1/3",@"2/3",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"};

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
   
    if([[[intervalData shutter] hdr] evInterval] == .333) {
        [picker selectRow:0 inComponent:0 animated:false];

    }
    else if([[[intervalData shutter] hdr] evInterval] == .333) {
        [picker selectRow:1 inComponent:0 animated:false];

    }
    else {
        NSLog(@"Setting -- %i", (int)[[[intervalData shutter] hdr] evInterval]);
        [picker selectRow:(int)[[[intervalData shutter] hdr] evInterval] inComponent:0 animated:false];

    }
    [[[self navigationController] tabBarController] tabBar].hidden = YES;

    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return evValuesThirdsSize;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {

    
    return evValuesThirds[row];
} 


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    NSLog(@"selected: row %i comp %i", row, component );
    NSLog(@"setting %f", evModelValues[row]);

    [[[intervalData shutter] hdr] setEvInterval:evModelValues[row]];
    
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
