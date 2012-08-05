//
//  IntervalometerCountDownViewController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
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

IntervalData *intervalData;

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
    
    intervalData = [IntervalData getInstance];
    
    /*
     
     TODO: remove intervaolmeter in app delegate
    intervalometerModel = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalometerModel];
    */

    intervalometerModel = [IIntervalometer new];
    
    [intervalometerModel setIntervalometerCountdownViewControllerReference:self];
    
    [[[self navigationController] tabBarController] tabBar].hidden = YES;
     
    [[intervalData shutter] initializeCurrentLength];

    [self setLabels];
    running = true;
    [intervalometerModel startIntervalometer];
    
    if([[intervalData interval] intervalEnabled]) {
        if([[intervalData duration] unlimitedDuration]) {
            [unlimitedDuration setHidden:false];
            [durationTime setHidden:true];
            unlimitedDuration.text = @"Unlimited Duration";
        }
        else {
            [unlimitedDuration setHidden:true];
            [durationTime setHidden:false];
            
            durationTime.text = [[[intervalData duration] time] toStringDownToSeconds];
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
    NSLog(@"Set labels");
        
    if([[intervalData interval] intervalEnabled]) {
        interval.textAlignment = UITextAlignmentRight;
        interval.text =  [[[intervalData interval] time] toStringDownToSeconds];
    }
    else {
        interval.text = @"Off";
        [intervalProgress setHidden:true];
    }
    
    shutterSpeed.textAlignment = UITextAlignmentRight;
    if([[[intervalData shutter] getMaxTime] totalTimeInSeconds] < 1) {
        
        shutterSpeed.text = @"Subsecond";
        [shutterProgress setHidden:true];
        
    }
    else if([[intervalData shutter] mode] == HDR_MODE) {
        shutterSpeed.text = @"HDR";
    }
    else {
        NSLog(@"Current length: %f " , [[[intervalData shutter] currentLength] totalTimeInSeconds]);
        if([[[intervalData shutter] currentLength] hours] == 0) {
            shutterSpeed.text = [[[intervalData shutter] currentLength] toStringDownToMilliseconds];
        }
        else {
            shutterSpeed.text = [[[intervalData shutter] currentLength] toStringDownToSeconds];
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
                NSLog(@"Play");
                if(running)
                    [intervalometerModel stopIntervalometer];
                else
                    [intervalometerModel stopIntervalometer];
                running = !running;
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


@end
