//
//  HDRViewController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "HDRViewController.h"
#import "AppDelegate.h"
#import "IntervalData.h"
#import "FractionConverter.h"
#import "Shutter.h"

@interface HDRViewController() 
-(void)loadShotsTickMarks;
-(void) clearTickMarks;
-(void) setLightMeterAxis;
@end

@implementation HDRViewController
@synthesize axis0Label;
@synthesize axis1Label;
@synthesize axis2Label;
@synthesize axis3Label;

UIImageView *imageViewArray[15];

@synthesize exposureValueLabel, numberOfShotsLabel, shutterLengthLabel,
pos1EVTick, neg1EVTick, centerEVTick;

IntervalData *intervalData;

-(void) viewWillAppear:(BOOL)animated {
    intervalData = [IntervalData getInstance];

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
    
    [self loadShotsTickMarks];
    [self setLightMeterAxis];
    [[[intervalData shutter] hdr] getMaxShutterLength];
}


-(void)loadShotsTickMarks {

    [self clearTickMarks];
    
    // coordinates based on 480x320 display dimensions
    // yBase - top of screen to top of tick - 125 px
    // xLeft - 35 from left edge
    // xRight - 35 from right edge (about)
    // xRange - 250
    
    // tick size - 39 px h x 22 (must be smaller)  < 7 shots
    
    
    int ticks;
    float xTick;
    float yTick; 
    float xLeft;
    float xRight;
    float xLength;
    float yBase;
    if(IDIOM == IPAD) {
        ticks = [[[intervalData shutter] hdr] numberOfShots];
        xTick = 20.0f; 
        yTick = 70.0f; 
        xLeft = 115.0f;
        xRight = 630.0f;
        xLength = xRight - xLeft;
        yBase = 156;
    } else {
        ticks = [[[intervalData shutter] hdr] numberOfShots];
        xTick = 10.0f; 
        yTick = 39.0f; 
        xLeft = 33.0f;
        xRight = 274.0f;
        xLength = xRight - xLeft;
        yBase = 61.0f;
    }
    

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
}

-(void) clearTickMarks {
    for(int i = 0; i < 15; i++) {
        [imageViewArray[i] removeFromSuperview];
    }
}

-(void) setLightMeterAxis {
    float totalDynamicRange = ([[[intervalData shutter] hdr] numberOfShots] - 1) * [[[intervalData shutter] hdr] evInterval];
    axis0Label.text = fractionConverter(totalDynamicRange / 2);
    axis1Label.text = fractionConverter(totalDynamicRange / 4);
    axis2Label.text = axis1Label.text;
    axis3Label.text = axis0Label.text;
}

- (void)viewDidUnload {
    [self setAxis0Label:nil];
    [self setAxis1Label:nil];
    [self setAxis2Label:nil];
    [self setAxis3Label:nil];
    [super viewDidUnload];
}
@end
