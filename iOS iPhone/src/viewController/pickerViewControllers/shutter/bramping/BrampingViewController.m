//
//  BrampingViewController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
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
