//
//  SingleShotViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SingleShotViewController.h"
#import "Time.h"
#import <AudioToolbox/AudioToolbox.h>

#import "AppDelegate.h"
#import "IntervalData.h"


@implementation SingleShotViewController
@synthesize fireButtonLabel;

@synthesize useInfoMessage, fireButton, pressHoldSegment;

AudioOutputController * audioOutput;

typedef enum  {
    PRESS_UP = 0,
    PRESS_DOWN = 1,
    HOLD_UP = 2,
    HOLD_DOWN = 3
} ButtonState;

ButtonState state;

-(void) viewWillAppear:(BOOL)animated {
    AppDelegate * d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    audioOutput = [[d getIntervalData] audioOutput]; 

    [self pressHoldDidChange];
}

-(IBAction) fireTownDown {
    if(state == PRESS_UP) {
        NSLog(@"press down");
        state = PRESS_DOWN;
        self.fireButtonLabel.text = @"";
        [audioOutput fireButtonPressed];
    }
    else if(state == HOLD_UP) {
        state = HOLD_DOWN;
        //[fireButton setHighlighted:true];
        NSLog(@"set hold down");
        self.fireButtonLabel.text = @"Stop";        
        [fireButton setHighlighted:false];
        [audioOutput fireButtonPressed];
    }
    else if(state == HOLD_DOWN) {
        NSLog(@"set hold up");
        state = HOLD_UP;
        [fireButton setHighlighted:false];
        self.fireButtonLabel.text = @"Start";

        [audioOutput fireButtonDepressed];
    }
    
}

-(IBAction) fireTownUp {
    if(state == PRESS_DOWN) {
        NSLog(@"set press up");
        [audioOutput fireButtonDepressed];
        state = PRESS_UP;
        self.fireButtonLabel.text = @"Fire!";
    }
   
}

-(IBAction) pressHoldDidChange {
    NSLog(@"Value: %i", [self.pressHoldSegment selectedSegmentIndex] );
    
    // press=0 | hold=1
    if(state != PRESS_DOWN && state != HOLD_DOWN) {
        if([self.pressHoldSegment selectedSegmentIndex] == 0 ) {
            NSLog(@"PRESS UP");
            state = PRESS_UP;
            self.fireButtonLabel.text = @"Fire!";
        }
        else {
            NSLog(@"HOLD UP");
            state = HOLD_UP;
            self.fireButtonLabel.text = @"Start";

        }
    }
    else {
        if([self.pressHoldSegment selectedSegmentIndex] == 0 ) {
            [pressHoldSegment setSelectedSegmentIndex:1];
        }
        else {
            [pressHoldSegment setSelectedSegmentIndex:0];
        }
    }
}



- (void)viewDidUnload {
    [self setFireButtonLabel:nil];
    [super viewDidUnload];
}
@end
