//
//  IntervalometerCountDownViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "IntervalometerCountDownViewController.h"


#import "MainTabBarController.h"

#import "AppDelegate.h"
#import "IntervalData.h"
#import "IIntervalometer.h"

@implementation IntervalometerCountDownViewController

@synthesize navigation, shutterSpeed, unlimitedDuration, durationTime, 
interval, stopButton, intervalProgress, shutterProgress, imageView;

IntervalData *intervalData;

IIntervalometer *intervalometerModel;

-(id)init {
    self.navigationController.navigationBarHidden = NO;

    return 0;
}

-(void) viewWillAppear:(BOOL)animated {
    
    [intervalProgress setProgress:0];
    [shutterProgress setProgress:0];
    
    [self.navigationController setNavigationBarHidden:YES animated:false];    
    
    intervalData = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalData];
    
    intervalometerModel = [(AppDelegate *)[[UIApplication sharedApplication] delegate] getIntervalometerModel];
    [intervalometerModel setIntervalometerCountdownViewControllerReference:self];
    
    [[[self navigationController] tabBarController] tabBar].hidden = YES;
     
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
            //[intervalometerModel getNotification];
        }
    }
    else {
        [unlimitedDuration setHidden:false];
        [durationTime setHidden:true];
        unlimitedDuration.text = @"Single Shot";
        [stopButton setTitle:@"Return" forState:0];
    }
        
    if([[intervalData interval] intervalEnabled]) {
        interval.textAlignment = UITextAlignmentRight;
        interval.text =  [[[intervalData interval] time] toStringDownToSeconds];
    }
    else {
        interval.text = @"Off";
        [intervalProgress setHidden:true];
    }
    
    shutterSpeed.textAlignment = UITextAlignmentRight;
    shutterSpeed.text = [[[intervalData shutter] startLength] toStringDownToSeconds];
    
    [intervalometerModel startIntervalometer];
    

}

-(void) setIntervalText {
    
// remove
}

-(void) viewDidDisappear:(BOOL)animated {
    [intervalometerModel stopIntervalometer];
}

-(IBAction) stopButtonPressed {
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

-(IBAction) testButtonPressed {
    
    //hide the back button
    [navigation setHidesBackButton:true];
}



@end
