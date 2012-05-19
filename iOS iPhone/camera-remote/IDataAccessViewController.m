
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


@implementation IDataAccessViewController

@synthesize warningBackground;
@synthesize warningLabel;
@synthesize hardwareChecker;
@synthesize cameraController;
@synthesize intervalData;


-(void) viewWillAppear:(BOOL)animated {
    AppDelegate * d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.cameraController = [[d getIntervalData] cameraController]; 
    
    [self hardwareCheck];
    self.hardwareChecker = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                        target:self
                                                      selector:@selector(hardwareCheck)
                                                      userInfo:nil
                                                       repeats:YES];
    
}

-(void) hardwareCheck {
    if([cameraController isHardwareConnected]) {
        if([cameraController class] == [AudioOutputCameraController class]) {
            [self.warningLabel setHidden:true];
            [self.warningBackground setHidden:true];
            MPMusicPlayerController *iPod = [MPMusicPlayerController iPodMusicPlayer];
            float volumeLevel = iPod.volume;
            if(volumeLevel < 1.0) {
                warningLabel.text = @"Headphone volume too low to communicate with Trigger Happy";
                [self.warningLabel setHidden:false];
                [self.warningBackground setHidden:false];
            }
            else {
                [self.warningLabel setHidden:true];
                [self.warningBackground setHidden:true];
            }
        }
    }
    else {
        if([cameraController class] == [AudioOutputCameraController class]) {
            warningLabel.text = @"The Trigger Happy Unit is not plugged into the headphone port";
        }
        else {
            warningLabel.text = @"Not plugged in - ICameraController inheritant";
        }
        [self.warningLabel setHidden:false];
        [self.warningBackground setHidden:false];
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    [self.hardwareChecker invalidate];
}

-(void) viewDidUnload {
    [self setIntervalData:nil];
    [self setWarningLabel:nil];
    [self setCameraController:nil];
    [self setWarningBackground:nil];
    [self.hardwareChecker invalidate];
    [self setHardwareChecker:nil];
}

@end
