//  IDataAccessViewController.m
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

#import "IDataAccessViewController.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AudioOutputCameraController.h"
#import "InfoViewController.h"
#import "HardwareManager.h"

@interface IDataAccessViewController() 
@end

@implementation IDataAccessViewController

@synthesize visible;

-(void) viewWillAppear:(BOOL)animated {
    cameraController = [HardwareManager getInstance].cameraController;
    
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
                infoViewController.text = @"Set volume to max. Volume could be too low.";
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
            infoViewController.text = @"Please plug the Trigger Happy Unit into headphone port.";
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
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [cameraController pausePlayRemoteEventRecieved];
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
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
    cameraController = nil;
    hardwareChecker = nil;
    infoViewController = nil;
}

@end
