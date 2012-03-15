//
//  HDRViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HDRShotsViewController.h"
#include "IntervalData.h"
#include "AppDelegate.h"

@implementation HDRShotsViewController

@synthesize picker;

IntervalData *intervalData;

const int evValuesSize = 5;
const int evValues[evValuesSize] = {1,3,5,7,9};


- (void)viewDidLoad {
    [super viewDidLoad];
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
        
  
    [picker selectRow:2 inComponent:0 animated:false];
    

}

- (void) viewDidAppear:(BOOL)animated {
    
    [[[self navigationController] tabBarController] tabBar].hidden = YES;
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return evValuesSize;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    
    return [[NSString alloc] initWithFormat:@"%d", evValues[row]];
} 

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    NSLog(@"selected: row %i comp %i", row, component );
    
    
    [intervalData setNumberOfShots:evValues[row]];
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
