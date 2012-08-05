//
//  HDREVViewController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "HDREVViewController.h"
#include "IntervalData.h"
#include "AppDelegate.h"
//#include "FractionConverter.h"

@implementation HDREVViewController

@synthesize picker;


IntervalData *intervalData;

int prevRowIndex;


//base 3
// due to Apple's fail, we can map anything
const int evValuesThirdsSize = 10;
const double evModelValues[evValuesThirdsSize] = {.333,.666,1,2,3,4,5,6,7,8};
NSString * evValuesThirds[evValuesThirdsSize] = {@"1/3",@"2/3",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"};

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
   
    if([[[intervalData shutter] hdr] evInterval] == .333) {
        [picker selectRow:0 inComponent:0 animated:false];

    }
    else if([[[intervalData shutter] hdr] evInterval] == .666) {
        [picker selectRow:1 inComponent:0 animated:false];

    }
    else {
        NSLog(@"Setting -- %i", (int)[[[intervalData shutter] hdr] evInterval]);
        [picker selectRow:(int)[[[intervalData shutter] hdr] evInterval] + 1 inComponent:0 animated:false];

    }
    [[[self navigationController] tabBarController] tabBar].hidden = YES;

    prevRowIndex = 0;
}

-(void) viewDidLoad {
    if(IDIOM == IPAD)
        infoViewController = [InfoViewController withLocationForPad:82 and:300];
    else
        infoViewController = [InfoViewController withLocationForPhone:0 and:277];
    
    
    infoViewController.text =  @"The exposure between each shot in the bracket";
    infoViewController.type = InfoViewControllerInfo;
    [self.view addSubview:infoViewController.view];

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


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    int previousEVInterval = [[[intervalData shutter] hdr] evInterval];
    
    [[[intervalData shutter] hdr] setEvInterval:evModelValues[row]];
    
    if([[[intervalData shutter] hdr] getMaxShutterLength] >= [[[intervalData interval] time] totalTimeInSeconds]) {
        [[[intervalData shutter] hdr] setEvInterval:previousEVInterval];
        [self.picker selectRow:prevRowIndex inComponent:0 animated:false];
        infoViewController.text = @"The cumulative shutter length of each shot in the bracket must be shorter than the interval";
        infoViewController.type = InfoViewControllerWarning;
    }
    else {
        infoViewController.text = [[NSString alloc] initWithFormat:@"The exposure between each shot in the bracket will differ by %@ EV", evValuesThirds[row]];
        infoViewController.type = InfoViewControllerInfo;
    }

    
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (void)viewDidUnload
{
    infoViewController = nil;
    [super viewDidUnload];
    self.picker = nil;
}

@end
