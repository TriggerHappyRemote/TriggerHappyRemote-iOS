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

@synthesize instructionLabel;
@synthesize warningBackground;
@synthesize picker;

IntervalData *intervalData;

const int shotsSize = 7;
const int shotsOptions[shotsSize] = {3,5,7,9,11,13,15};

//const int indexToNumberOfShots[shotsSize][2] = {{1,3},{2,5},{3,7},{4,9},{5,11},{6,13},{7,15}};
int prevRowIndex;

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    [warningBackground setHidden:true];
    [instructionLabel setHidden:true];
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
        
  
    [[[self navigationController] tabBarController] tabBar].hidden = YES;

    // Mapping works like this:
    //     {3,5,7,9,11,13,15} -> {1,2,3,4,5,6,7} by noShots / 2 - 1 w/ integer math
    int selected = [[[intervalData shutter] hdr] numberOfShots] / 2  - 1;
    [picker selectRow:selected inComponent:0 animated:false];
    prevRowIndex = 0;
    

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
    [warningBackground setHidden:true];
    [instructionLabel setHidden:true];
    
    int previousNumberOfShots = [[[intervalData shutter] hdr] numberOfShots];
    
    [[[intervalData shutter] hdr] setNumberOfShots:shotsOptions[row]];
    
    if([[[intervalData shutter] hdr] getMaxShutterLength] >= [[[intervalData interval] time] totalTimeInSeconds]) {
        [[[intervalData shutter] hdr] setNumberOfShots:previousNumberOfShots];
        [self.picker selectRow:prevRowIndex inComponent:0 animated:false];
        [warningBackground setHidden:false];
        [instructionLabel setHidden:false];
    }
    else {
        prevRowIndex = row;
    }
}

-(IBAction)textFieldReturn:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewDidUnload {
    [self setInstructionLabel:nil];
    [self setWarningBackground:nil];
    [super viewDidUnload];
    self.picker = nil;
}

@end
