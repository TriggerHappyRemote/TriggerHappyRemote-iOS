//
//  IShutterSelectorViewController.m
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "IShutterSelectorViewController.h"
#import "IntervalData.h"
#import "InfoViewController.h"

@implementation IShutterSelectorViewController

@synthesize infoMessage, warningMessage;

-(void) viewDidLoad {
    [super viewDidLoad];
}

-(void) boundsCheck:(NSInteger)row inComponent:(NSInteger)component withPreviousLength:(Time *)time {
    Time * max = [[self.intervalData interval] time];
    if([[self.intervalData interval] intervalEnabled] && [self.time totalTimeInSeconds] >= [max totalTimeInSeconds]) {
        
        Time * newMax = [Time new];
        [newMax setTotalTimeInSeconds:[max totalTimeInSeconds] - 1];
        [self.picker selectRow:[newMax hours] inComponent:0 animated:false];
        [self.picker selectRow:[newMax minutes] inComponent:1 animated:false];
        [self.picker selectRow:[newMax seconds] inComponent:2 animated:false];
        [self changeHour:[newMax hours]];
        [self changeMinute:[newMax minutes]];
        [self changeSecond:[newMax seconds]];
        
        infoViewController.text = self.warningMessage;
        infoViewController.type = InfoViewControllerWarning;
    } else {
        infoViewController.text = self.infoMessage;
        infoViewController.type = InfoViewControllerInfo;
    }
}

@end
