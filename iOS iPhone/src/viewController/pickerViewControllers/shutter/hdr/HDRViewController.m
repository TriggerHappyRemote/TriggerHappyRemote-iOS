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

-(void) viewWillAppear:(BOOL)animated {
    if(IPHONE_4_0) {
        self.view.backgroundColor = [UIColor blackColor];
        [background setFrame:CGRectMake(background.frame.origin.x, -45, background.frame.size.width, 480)];
    }
    
    [[[self navigationController] tabBarController] tabBar].hidden = YES;
    
    numberOfShotsLabel.text = [[NSString alloc] initWithFormat:@"%i Shots", [[[[IntervalData getInstance] shutter] hdr] numberOfShots]];
    
    double EVInterval = [[[[IntervalData getInstance] shutter] hdr] evInterval];
    
    if(EVInterval == .333) {
        exposureValueLabel.text = @"1/3 EV Interval";
    }
    else if(EVInterval == .666) {
        exposureValueLabel.text = @"2/3 EV Interval";
    }
    else {
        exposureValueLabel.text = [[NSString alloc] initWithFormat:@"%i EV Interval", (int)EVInterval];
    }
    shutterLengthLabel.text = [[NSString alloc] initWithFormat:@"%@ Shutter Length", [[[[IntervalData getInstance] shutter] hdr] getButtonData]];
    
    [self loadShotsTickMarks];
    [self setLightMeterAxis];
    [[[[IntervalData getInstance] shutter] hdr] getMaxShutterLength];
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
        ticks = [[[[IntervalData getInstance] shutter] hdr] numberOfShots];
        xTick = 20.0f; 
        yTick = 70.0f; 
        xLeft = 115.0f;
        xRight = 630.0f;
        xLength = xRight - xLeft;
        yBase = 156;
    } else {
        ticks = [[[[IntervalData getInstance] shutter] hdr] numberOfShots];
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
    float totalDynamicRange = ([[[[IntervalData getInstance] shutter] hdr] numberOfShots] - 1) * [[[[IntervalData getInstance] shutter] hdr] evInterval];
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
    background = nil;
    [super viewDidUnload];
}
@end
