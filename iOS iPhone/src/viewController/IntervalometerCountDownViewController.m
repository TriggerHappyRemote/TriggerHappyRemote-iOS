//
//  IntervalometerCountDownViewController.m
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

#import "IntervalometerCountDownViewController.h"



#import "AppDelegate.h"
#import "IntervalData.h"
#import "IIntervalometer.h"

#import "Shutter.h"
#import "Interval.h"
#import "IntervalDuration.h"

@interface IntervalometerCountDownViewController() 
-(void) setLabels;
@end

@implementation IntervalometerCountDownViewController

@synthesize navigation, shutterSpeed, unlimitedDuration, durationTime, 
interval, stopButton, intervalProgress, shutterProgress, imageView;

IIntervalometer *intervalometerModel;

bool running;

-(id)init {
    self.navigationController.navigationBarHidden = NO;

    return 0;
}

-(void) viewWillAppear:(BOOL)animated {
    
    [intervalProgress setProgress:0];
    [shutterProgress setProgress:0];
    
    [self.navigationController setNavigationBarHidden:YES animated:false];    
    
    
    /*
     
     TODO: remove intervaolmeter in app delegate
    intervalometerModel = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalometerModel];
    */

    intervalometerModel = [IIntervalometer new];
    
    [intervalometerModel setIntervalometerCountdownViewControllerReference:self];
    
    [[[self navigationController] tabBarController] tabBar].hidden = YES;
     
    [[[IntervalData getInstance] shutter] initializeCurrentLength];

    [self setLabels];
    running = true;
    [intervalometerModel startIntervalometer];
    
    if([[[IntervalData getInstance] interval] intervalEnabled]) {
        if([[[IntervalData getInstance] duration] unlimitedDuration]) {
            [unlimitedDuration setHidden:false];
            [durationTime setHidden:true];
            unlimitedDuration.text = @"Unlimited Duration";
        }
        else {
            [unlimitedDuration setHidden:true];
            [durationTime setHidden:false];
            
            durationTime.text = [[[[IntervalData getInstance] duration] time] toStringDownToSeconds];
        }
    }
    else {
        [unlimitedDuration setHidden:false];
        [durationTime setHidden:true];
        unlimitedDuration.text = @"Single Shot";
        [stopButton setTitle:@"Return" forState:0];
    }

    

}

-(void) setLabels {
    
    if([[[IntervalData getInstance] interval] intervalEnabled]) {
        interval.textAlignment = UITextAlignmentRight;
        interval.text =  [[[[IntervalData getInstance] interval] time] toStringDownToSeconds];
    }
    else {
        interval.text = @"Off";
        [intervalProgress setHidden:true];
    }
    
    shutterSpeed.textAlignment = UITextAlignmentRight;
    if([[[[IntervalData getInstance] shutter] getMaxTime] totalTimeInSeconds] < 1) {
        shutterSpeed.text = @"Subsecond";
        [shutterProgress setHidden:true];
    }
    else if([[[IntervalData getInstance] shutter] mode] == HDR_MODE) {
        shutterSpeed.text = @"HDR";
    }
    else {
        if([[[[IntervalData getInstance] shutter] currentLength] hours] == 0) {
            shutterSpeed.text = [[[[IntervalData getInstance] shutter] currentLength] toStringDownToMilliseconds];
        }
        else {
            shutterSpeed.text = [[[[IntervalData getInstance] shutter] currentLength] toStringDownToSeconds];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

-(void) viewDidDisappear:(BOOL)animated {
    running = false;
    [intervalometerModel stopIntervalometer];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

-(IBAction) stopButtonPressed {
    running = false;
    [intervalometerModel stopIntervalometer];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

-(void) notifyOfInterrupt:(NSString *) currentTime {
    durationTime.text = currentTime;
}

-(void) notifyOfInterruptToUpdateIntervalProgress:(float) percentage {
    [intervalProgress setProgress:percentage];
    if(percentage == 0) {
        [self setLabels];
    }
}

-(void) notifyOfInterruptToUpdatShutterProgress:(float) percentage {
    [shutterProgress setProgress:percentage];
}



-(void) notifyOfDurationEnd { 
    [durationTime setHidden:true];
    unlimitedDuration.text = @"Duration Ended";
    [unlimitedDuration setHidden:false];
    [stopButton setTitle:@"Return" forState:0];
    
}

-(void) viewDidLoad {
    [navigation setHidesBackButton:true];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
                if(running)
                    [intervalometerModel stopIntervalometer];
                else
                    [intervalometerModel stopIntervalometer];
                running = !running;
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


@end
