
//
//  IDataAccessViewController.m
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "IDataAccessViewController.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AudioOutputCameraController.h"
#import "InfoViewController.h"

@interface IDataAccessViewController() 
@end

@implementation IDataAccessViewController

@synthesize visible;

-(void) viewDidLoad {
    AppDelegate * d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    cameraController = [[d getIntervalData] cameraController]; 
}

-(void) viewWillAppear:(BOOL)animated {
    [self hardwareCheck];
    
    hardwareChecker = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                        target:self
                                                      selector:@selector(hardwareCheck)
                                                      userInfo:nil
                                                       repeats:YES];
    

    
}


-(void) hardwareCheck {
    if([cameraController isHardwareConnected]) {
        if([cameraController class] == [AudioOutputCameraController class]) {
            infoViewController.hidden = true;
            
            
#if !(TARGET_IPHONE_SIMULATOR)
            MPMusicPlayerController *iPod = [MPMusicPlayerController iPodMusicPlayer];
            float volumeLevel = iPod.volume;
            if(volumeLevel < 1.0) {
                infoViewController.text = @"Headphone volume too low to communicate with Trigger Happy";
                infoViewController.hidden = false;
            }
            else {
                infoViewController.hidden = true;
            }
#endif
        }
        
    }
    else {
        if([cameraController class] == [AudioOutputCameraController class]) {
            
            infoViewController.text = @"The Trigger Happy Unit is not plugged into the headphone port";
        }
        else {
            infoViewController.text = @"Not plugged in - ICameraController inheritant";
        }
        infoViewController.hidden = false;
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    [hardwareChecker invalidate];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

-(void) viewDidDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    NSLog(@"Recived remote control even");
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
                NSLog(@"Play");
                [cameraController fireButtonDepressed];
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"Prev");
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"stop");
                break;
                
            default:
                break;
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}


-(void) viewDidUnload {
    intervalData = nil;
    cameraController = nil;
    hardwareChecker = nil;
    infoViewController = nil;
}

@end
