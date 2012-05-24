//
//  HDRViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HDRViewController.h"
#import "AppDelegate.h"
#import "IntervalData.h"

@implementation HDRViewController

@synthesize exposureValueLabel, numberOfShotsLabel, shutterLengthLabel,
pos1EVTick, neg1EVTick, centerEVTick;


IntervalData *intervalData;


-(void) viewWillAppear:(BOOL)animated {
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];

    [[[self navigationController] tabBarController] tabBar].hidden = YES;
    
    numberOfShotsLabel.text = [[NSString alloc] initWithFormat:@"%i Shots", [[[intervalData shutter] hdr] numberOfShots]];
    
    double EVInterval = [[[intervalData shutter] hdr] evInterval];
    
    if(EVInterval == .333) {
        exposureValueLabel.text = @"1/3 EV Interval";
    }
    else if(EVInterval == .666) {
        exposureValueLabel.text = @"2/3 EV Interval";
    }
    else {
        exposureValueLabel.text = [[NSString alloc] initWithFormat:@"%i EV Interval", (int)EVInterval];
    }
    shutterLengthLabel.text = [[NSString alloc] initWithFormat:@"%@ Shutter Length", [[[intervalData shutter] hdr] getButtonData]];
    
/*
    numberOfShotsLabel.text = [[NSString alloc] initWithFormat:@"%d Shot", [intervalData getNumberOfShots]];
    
    [intervalData setAutoShutter:false];
    int shutterSeconds = [[intervalData shutterSpeed] seconds];
    shutterLengthLabel.text = [[NSString alloc] initWithFormat:@"%d Second Base Shutter", shutterSeconds];
    
    
    NSString * ev;
    int evValue = [intervalData getEV];
    if(evValue % 3 == 0) {
        ev = [[NSString alloc] initWithFormat:@"%d",evValue/3];
    }
    else {
        ev = [[NSString alloc] initWithFormat:@"%d/3",evValue];
    }
    
    exposureValueLabel.text = [[NSString alloc] initWithFormat:@"%@ EV Interval", ev];
    
    //[centerEVTick setHidden:true];
    //[self.view addSubview:centerEVTick];
    
    
    [self.view drawRect:CGRectMake(20, 30, 20, 30)];
    */

    
    
}



@end
