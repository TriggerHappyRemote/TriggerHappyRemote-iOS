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

@interface HDRViewController() 
-(void)loadShotsTickMarks;
-(void) clearTickMarks;
@end

@implementation HDRViewController

UIImageView *imageViewArray[15];

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

    [self loadShotsTickMarks];
    
}


-(void)loadShotsTickMarks {

    [self clearTickMarks];
    
    // coordinates based on 480x320 display dimensions
    // yBase - top of screen to top of tick - 125 px
    // xLeft - 35 from left edge
    // xRight - 35 from right edge (about)
    // xRange - 250
    
    // tick size - 39 px h x 22 (must be smaller)  < 7 shots
    
    
    const int ticks = [[[intervalData shutter] hdr] numberOfShots];

    const float xTick = 10.0f; 
    const float yTick = 39.0f; 
    const float xLeft = 33.0f;
    const float xRight = 274.0f;
    const float xLength = xRight - xLeft;
    const float yBase = 61.0f;
    

    // distance between ticks
    const float xDelta = xLength / (float)(ticks-1);
    
    
    for(int i = 0; i < ticks; i++) {
        CGRect tickRec = CGRectMake(xLeft + i*xDelta, yBase, xTick, yTick);
        UIImageView *tickImg = [[UIImageView alloc] initWithFrame:tickRec];
        [tickImg setImage:[UIImage imageNamed:@"lightMeterTick.png"]];
        tickImg.opaque = YES; // explicitly opaque for performance
        [self.view addSubview:tickImg];
        imageViewArray[i] = tickImg;
    }
    
//    CGRect myImageRect = CGRectMake(28.0f, 61.0f, 22.0f, 39.0f);
//    UIImageView *myImage = [[UIImageView alloc] initWithFrame:myImageRect];
//    [myImage setImage:[UIImage imageNamed:@"lightMeterTick.png"]];
//    myImage.opaque = YES; // explicitly opaque for performance
//    [self.view addSubview:myImage];
//    
//    CGRect myImageRect2 = CGRectMake(268.0f, 61.0f, 22.0f, 39.0f);
//    UIImageView *myImage2 = [[UIImageView alloc] initWithFrame:myImageRect2];
//    [myImage2 setImage:[UIImage imageNamed:@"lightMeterTick.png"]];
//    myImage2.opaque = YES; // explicitly opaque for performance
//    [self.view addSubview:myImage2];
    
    

}

-(void) clearTickMarks {
    for(int i = 0; i < 15; i++) {
        [imageViewArray[i] removeFromSuperview];
    }
}






@end
