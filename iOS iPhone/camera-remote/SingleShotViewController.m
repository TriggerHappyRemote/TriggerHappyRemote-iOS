//
//  SingleShotViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SingleShotViewController.h"

@implementation SingleShotViewController

@synthesize useInfoMessage, fireButton;

-(IBAction) fireTownDown {
    NSLog(@"Fire touch down");
}

-(IBAction) fireTownUp {
    NSLog(@"Fire touch up");
}

@end
