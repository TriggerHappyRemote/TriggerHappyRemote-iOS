//
//  HDRViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HDREVViewController.h"
#include "IntervalData.h"
#include "AppDelegate.h"

@implementation HDREVViewController

@synthesize picker, exposureValues;


IntervalData *intervalData;


//base 3
const int evValuesThirdsSize = 8;
const int evValuesThirds[evValuesThirdsSize] = {1,2,3,4,5,6,9,12};


- (void)viewDidLoad {
    [super viewDidLoad];
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
    
    
    
    
    
    self.exposureValues = [[NSMutableArray alloc] initWithCapacity:12];
    
    
//    if([intervalData isThirdStop])
//        [self loadThirds];
//    else
//        [self loadHalfs];
    
    [self loadThirds];
    
   
    
    [picker selectRow:2 inComponent:0 animated:false];
    
    
}

- (void) loadThirds {
    self.exposureValues = [[NSMutableArray alloc] initWithObjects:
                           @"1/3", @"2/3", @"1", @"4/3",
                           @"5/3", @"2", @"3",
                           @"4",
                           nil];   
}

-(IBAction) toggleHalfThirds {
    
    //not used now
    if([intervalData isThirdStop])
        NSLog(@"Third");
    else
        NSLog(@"Half");

    [intervalData toggleThirdStop];
    if([intervalData isThirdStop])
        [self loadThirds];
    else
        [self loadHalfs];
    [picker reloadAllComponents];
    
    
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
    return evValuesThirdsSize;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    
    
    NSString * ev;
    if(evValuesThirds[row] % 3 == 0) {
        ev = [[NSString alloc] initWithFormat:@"%d",evValuesThirds[row]/3];
    }
    else {
        ev = [[NSString alloc] initWithFormat:@"%d/3",evValuesThirds[row]];
    }
    
    return ev;
} 

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    NSLog(@"selected: row %i comp %i", row, component );
    [intervalData setEV:evValuesThirds[row]];
    
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
