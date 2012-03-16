//
//  SingleShotViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SingleShotViewController.h"
#import "Time.h"

@implementation SingleShotViewController

@synthesize useInfoMessage, fireButton;

-(void) viewDidAppear:(BOOL)animated {
    // just for testing
    Time * t = [Time new];

    [t setHours:10];
    NSLog(@"Hours: %i", [t hours] );
    [t setMinutes:11];
    NSLog(@"Minutes: %i", [t minutes] );
    [t setSeconds:12];
    NSLog(@"Seconds: %i", [t seconds] );

}

-(IBAction) fireTownDown {
    NSLog(@"Fire touch down");
}

-(IBAction) fireTownUp {
    NSLog(@"Fire touch up");
}

@end
