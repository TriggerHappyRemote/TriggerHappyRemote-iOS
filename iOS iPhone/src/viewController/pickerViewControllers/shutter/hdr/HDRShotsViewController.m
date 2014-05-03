//
//  HDRViewController.m
//  Copyright (c) 2014 Kevin Harrington
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  Created by Kevin Harrington on 1/9/12.
//  
//

#import "HDRShotsViewController.h"
#include "IntervalData.h"
#include "AppDelegate.h"
#import "InfoViewController.h"
#import "Shutter.h"
#import "Interval.h"

@interface HDRShotsViewController()
@property (nonatomic) int prevRowIndex;
@end

@implementation HDRShotsViewController

@synthesize picker;
@synthesize prevRowIndex;

const int shotsSize = 7;
const int shotsOptions[shotsSize] = {3,5,7,9,11,13,15};

//const int indexToNumberOfShots[shotsSize][2] = {{1,3},{2,5},{3,7},{4,9},{5,11},{6,13},{7,15}};


- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.tabBarController.tabBar.hidden = YES;

    // Mapping works like this:
    //     {3,5,7,9,11,13,15} -> {1,2,3,4,5,6,7} by noShots / 2 - 1 w/ integer math
    int selected = [IntervalData getInstance].shutter.hdr.numberOfShots / 2  - 1;
    [picker selectRow:selected inComponent:0 animated:false];
    prevRowIndex = 0;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    if(IDIOM == IPAD)
        infoViewController = [InfoViewController withLocationForPad:82 and:300];
    else
        infoViewController = [InfoViewController withLocationForPhone:0 and:277];
    
    
    infoViewController.text =  [[NSString alloc] initWithFormat:@"%i shots will be taken for each interval", [IntervalData getInstance].shutter.hdr.numberOfShots];
    infoViewController.type = InfoViewControllerInfo;
    [self.view addSubview:infoViewController.view];
        
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
    
    
    int previousNumberOfShots = [IntervalData getInstance].shutter.hdr.numberOfShots;
    
    [IntervalData getInstance].shutter.hdr.numberOfShots = shotsOptions[row];
    
    if([IntervalData getInstance].interval.intervalEnabled &&
       [[IntervalData getInstance].shutter.hdr getMaxShutterLength] >= [IntervalData getInstance].interval.time.totalTimeInSeconds) {
        [IntervalData getInstance].shutter.hdr.numberOfShots = previousNumberOfShots;
        [self.picker selectRow:prevRowIndex inComponent:0 animated:false];
        infoViewController.text = @"The cumulative shutter length must be shorter than the interval";
        infoViewController.type = InfoViewControllerWarning;
    }
    else {
        infoViewController.text = [[NSString alloc] initWithFormat:@"%i shots will be taken for each interval", [IntervalData getInstance].shutter.hdr.numberOfShots];
        infoViewController.type = InfoViewControllerInfo;
        prevRowIndex = row;
    }
}

-(IBAction)textFieldReturn:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewDidUnload {
    infoViewController = nil;
    [super viewDidUnload];
    self.picker = nil;
}

@end
