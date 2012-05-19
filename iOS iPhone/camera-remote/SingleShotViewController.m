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
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import "IntervalData.h"
#import "ICameraController.h"


@implementation SingleShotViewController
@synthesize fireButtonLabel;
@synthesize waringLabel;
@synthesize warningBackground;

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

NSTimer * headPhoneChecker;

-(void) viewWillAppear:(BOOL)animated {
    AppDelegate * d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    cameraController = [[d getIntervalData] cameraController]; 
    
    useInfoMessage.textAlignment = UITextAlignmentCenter;

    pressMessage = @"Press and hold for rapid fire or bulb";
    holdMessage = @"Press rapid fire sequence or a long exposure in bulb";

    [self checkIfHeaphonesPluggedIn];
    headPhoneChecker = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                        target:self
                                                      selector:@selector(checkIfHeaphonesPluggedIn)
                                                      userInfo:nil
                                                       repeats:YES];
    
    [self pressHoldDidChange];
}

-(void) checkIfHeaphonesPluggedIn {
    if([cameraController isHardwareConnected]) {
        [self.waringLabel setHidden:true];
        [self.warningBackground setHidden:true];
    }
    else {
        [self.waringLabel setHidden:false];
        [self.warningBackground setHidden:false];
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    [headPhoneChecker invalidate];
}

-(void) viewDidAppear:(BOOL)animated {
    MPMusicPlayerController *iPod = [MPMusicPlayerController iPodMusicPlayer];
    float volumeLevel = iPod.volume;
    if(volumeLevel < 1.0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Volume Too Low" message:@"Turn the volume to max, so Trigger Happy will work" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];        
    }
}

-(IBAction) fireTownDown {
    if(state == PRESS_UP) {
        NSLog(@"press down");
        state = PRESS_DOWN;
        self.fireButtonLabel.text = @"";
        [cameraController fireButtonPressed];
    }
    else if(state == HOLD_UP) {
        state = HOLD_DOWN;
        //[fireButton setHighlighted:true];
        NSLog(@"set hold down");
        self.fireButtonLabel.text = @"Stop";  
        useInfoMessage.text = @"Press to stop sequence";
        [fireButton setHighlighted:false];
        [cameraController fireButtonPressed];
    }
    else if(state == HOLD_DOWN) {
        NSLog(@"set hold up");
        state = HOLD_UP;
        [fireButton setHighlighted:false];
        self.fireButtonLabel.text = @"Start";
        useInfoMessage.text = holdMessage;


        [cameraController fireButtonDepressed];
    }
}

-(IBAction) fireTownUp {
    if(state == PRESS_DOWN) {
        NSLog(@"set press up");
        [cameraController fireButtonDepressed];
        state = PRESS_UP;
        self.fireButtonLabel.text = @"Fire!";
        useInfoMessage.text = pressMessage;

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
            useInfoMessage.text = pressMessage;
        }
        else {
            NSLog(@"HOLD UP");
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
    [self setWaringLabel:nil];
    [self setWarningBackground:nil];
    [super viewDidUnload];
}
@end
