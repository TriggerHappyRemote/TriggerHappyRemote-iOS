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
#import "Shutter.h"

@implementation BrampingViewController
@synthesize endShutterDataLabel;
@synthesize startShutterDataLabel;

- (void) viewWillAppear:(BOOL)animated {
    
    endShutterDataLabel.text = [[[[IntervalData getInstance] shutter] bramper] getEndShutterLabelText];
    
    startShutterDataLabel.text = [[[[IntervalData getInstance] shutter] bramper] getStartShutterLabelText];
    
}

- (void)viewDidUnload {
    [self setStartShutterDataLabel:nil];
    [self setEndShutterDataLabel:nil];
    [super viewDidUnload];
}
@end
