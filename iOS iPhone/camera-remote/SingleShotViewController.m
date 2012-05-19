//
//  SingleShotViewController.m
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "SingleShotViewController.h"
#import "Time.h"
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import "IntervalData.h"
#import "ICameraController.h"


@implementation SingleShotViewController
@synthesize fireButtonLabel;

@synthesize useInfoMessage, fireButton, pressHoldSegment;

NSString * pressMessage;
NSString * holdMessage;

ICameraController * cameraController;

typedef enum  {
    PRESS_UP = 0,
    PRESS_DOWN = 1,
    HOLD_UP = 2,
    HOLD_DOWN = 3
} ButtonState;

ButtonState state;

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:false];
    
    AppDelegate * d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    cameraController = [[d getIntervalData] cameraController]; 
    
    useInfoMessage.textAlignment = UITextAlignmentCenter;

    pressMessage = @"Press and hold for rapid fire or bulb";
    holdMessage = @"Press rapid fire sequence or a long exposure in bulb";
    
    [self pressHoldDidChange];
}

-(IBAction) fireTownDown {
    if(state == PRESS_UP) {
        state = PRESS_DOWN;
        self.fireButtonLabel.text = @"";
        [cameraController fireButtonPressed];
    }
    else if(state == HOLD_UP) {
        state = HOLD_DOWN;
        self.fireButtonLabel.text = @"Stop";  
        useInfoMessage.text = @"Press to stop sequence";
        [fireButton setHighlighted:false];
        [cameraController fireButtonPressed];
    }
    else if(state == HOLD_DOWN) {
        state = HOLD_UP;
        [fireButton setHighlighted:false];
        self.fireButtonLabel.text = @"Start";
        useInfoMessage.text = holdMessage;


        [cameraController fireButtonDepressed];
    }
}

-(IBAction) fireTownUp {
    if(state == PRESS_DOWN) {
        [cameraController fireButtonDepressed];
        state = PRESS_UP;
        self.fireButtonLabel.text = @"Fire!";
        useInfoMessage.text = pressMessage;

    }
   
}

-(IBAction) pressHoldDidChange {
    
    // press=0 | hold=1
    if(state != PRESS_DOWN && state != HOLD_DOWN) {
        if([self.pressHoldSegment selectedSegmentIndex] == 0 ) {
            state = PRESS_UP;
            self.fireButtonLabel.text = @"Fire!";
            useInfoMessage.text = pressMessage;
        }
        else {
            state = HOLD_UP;
            self.fireButtonLabel.text = @"Start";
            useInfoMessage.text = holdMessage;

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
