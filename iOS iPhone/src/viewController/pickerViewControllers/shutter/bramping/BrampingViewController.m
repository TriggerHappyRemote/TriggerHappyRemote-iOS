//
//  BrampingViewController.m
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "BrampingViewController.h"
#import "AppDelegate.h"
#import "IntervalData.h"

@implementation BrampingViewController
@synthesize endShutterDataLabel;
@synthesize startShutterDataLabel;

IntervalData * intervalData;

- (void) viewWillAppear:(BOOL)animated {
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
    
    endShutterDataLabel.text = [[[intervalData shutter] bramper] getEndShutterLabelText];
    
    startShutterDataLabel.text = [[[intervalData shutter] bramper] getStartShutterLabelText];
    
}

- (void)viewDidUnload {
    [self setStartShutterDataLabel:nil];
    [self setEndShutterDataLabel:nil];
    [super viewDidUnload];
}
@end
