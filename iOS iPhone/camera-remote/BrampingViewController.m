//
//  BrampingViewController.m
//  Trigger-Happy
//
//  Created by Kevin Harrington on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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
