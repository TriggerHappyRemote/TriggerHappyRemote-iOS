//
//  SingleShotViewController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "SingleShotViewController.h"
#import "Time.h"
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import "IntervalData.h"
#import "ICameraController.h"
#import "InfoViewController.h"

@interface SingleShotViewController()
-(void)enableCanFire;
@end

@implementation SingleShotViewController
@synthesize fireButtonLabel;

@synthesize useInfoMessage, fireButton, pressHoldSegment;

NSString * pressMessage;
NSString * holdMessage;

NSTimer * fireMinIntervalTimer;
bool canFire;

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
    canFire = true;
    
    AppDelegate * d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    cameraController = [[d getIntervalData] cameraController]; 
    
    useInfoMessage.textAlignment = UITextAlignmentCenter;

    pressMessage = @"Touch once to trigger, touch and hold for sequence";
    holdMessage = @"Touch once to start";
    
    [self pressHoldDidChange];
}

-(void) viewDidLoad {
    [super viewDidLoad];
    if(IDIOM == IPAD)
        infoViewController = [InfoViewController withLocationForPad:82 and:780];
    else
        infoViewController = [InfoViewController withLocationForPhone:0 and:323];
    [self.view addSubview:infoViewController.view];
}

-(void)enableCanFire {
    canFire = true;
}

-(IBAction) fireTownDown {
    
    if(canFire) {
        canFire = false;
        hardwareChecker = [NSTimer scheduledTimerWithTimeInterval:.3
                                                                target:self
                                                              selector:@selector(enableCanFire)
                                                              userInfo:nil
                                                               repeats:NO];
        
        if(state == PRESS_UP) {
            state = PRESS_DOWN;
            self.fireButtonLabel.text = @"";
            [cameraController fireButtonPressed];
        }
        else if(state == HOLD_UP) {
            state = HOLD_DOWN;
            self.fireButtonLabel.text = @"Stop";  
            useInfoMessage.text = @"Touch to stop sequence";
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
