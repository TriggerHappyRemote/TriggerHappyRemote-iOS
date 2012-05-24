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

const int shotsSize = 7;
const int shotsOptions[shotsSize] = {3,5,7,9,11,13,15};

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
        
  
    [[[self navigationController] tabBarController] tabBar].hidden = YES;

    // Mapping works like this:
    //     {3,5,7,9,11,13,15} -> {1,2,3,4,5,6,7} by noShots / 2 - 1 w/ integer math
    int selected = [[[intervalData shutter] hdr] numberOfShots] / 2  - 1;
    [picker selectRow:selected inComponent:0 animated:false];
    

}

- (void) viewDidLoad {
    [picker selectRow:3 inComponent:0 animated:false];

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return shotsSize;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [[NSString alloc] initWithFormat:@"%d", shotsOptions[row]];
} 

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component {
    NSLog(@"selected: row %i comp %i", row, component ); 
    [[[intervalData shutter] hdr] setNumberOfShots:shotsOptions[row]];
}

-(IBAction)textFieldReturn:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.picker = nil;
}

@end
