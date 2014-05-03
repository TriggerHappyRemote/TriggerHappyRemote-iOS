//
//  SingleShotViewController.m
//  Copyright (c) 2014 Kevin Harrington
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  Created by Kevin Harrington on 1/9/12.
//  
//

#import "SingleShotViewController.h"
#import "Time.h"
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import "IntervalData.h"
#import "ICameraController.h"
#import "InfoViewController.h"
#import "Constants.h"
#import "helpModalViewContollerViewController.h"

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
    [super viewWillAppear:animated];
    
    if(IPHONE_4_0) {
        // stretch the fire button
        [fireButton setFrame:CGRectMake(fireButton.frame.origin.x,fireButton.frame.origin.y,fireButton.frame.size.width,396)];
        // move the fire button to the center
        [fireButtonLabel setFrame:CGRectMake(fireButtonLabel.frame.origin.x,273,fireButtonLabel.frame.size.width,fireButtonLabel.frame.size.height)];

    }
    
    canFire = true;
    
    useInfoMessage.textAlignment = UITextAlignmentCenter;

    pressMessage = @"Touch once to trigger, touch and hold for sequence";
    holdMessage = @"Touch once to start";
    
    [self pressHoldDidChange];
}

-(void) viewDidLoad {
    [super viewDidLoad];    
    self.tabBarController.delegate = self;

    if(IDIOM == IPAD)
        infoViewController = [InfoViewController withLocationForPad:82 and:780];
    else if(IPHONE_4_0)
        infoViewController = [InfoViewController withLocationForPhone:0 and:408];
    else
        infoViewController = [InfoViewController withLocationForPhone:0 and:323];
    [self.view addSubview:infoViewController.view];
}

-(void)enableCanFire {
    canFire = true;
}

-(IBAction) fireTownDown {
    
    //if(canFire) {
        
        // TODO: figure out why the heck I do below:
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
    //}
    
}

-(IBAction) fireTownUp {
    if(state == PRESS_DOWN) {
        [cameraController fireButtonDepressed];
        state = PRESS_UP;
        self.fireButtonLabel.text = @"Trigger";
        useInfoMessage.text = pressMessage;

    }
   
}

-(IBAction) pressHoldDidChange {
    
    // press=0 | hold=1
    if(state != PRESS_DOWN && state != HOLD_DOWN) {
        if([self.pressHoldSegment selectedSegmentIndex] == 0 ) {
            state = PRESS_UP;
            self.fireButtonLabel.text = @"Trigger";
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

-(BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return state != PRESS_DOWN && state != HOLD_DOWN;
}

- (void)viewDidUnload {
    [self setFireButtonLabel:nil];
    [super viewDidUnload];
}

@end