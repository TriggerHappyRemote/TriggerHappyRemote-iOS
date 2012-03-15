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
#import "IntervalometerModel.h"

@implementation IntervalometerCountDownViewController

@synthesize navigation, shutterSpeed, unlimitedDuration, durationTime, 
interval, stopButton, intervalProgress, shutterProgress, imageView;

IntervalData *intervalData;

IntervalometerModel *intervalometerModel;

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
        
    if(intervalData.isUnlimitedDuration) {
        [unlimitedDuration setHidden:false];
        [durationTime setHidden:true];
        unlimitedDuration.text = @"Unlimited Duration";
    }
    else {
        [unlimitedDuration setHidden:true];
        [durationTime setHidden:false];
        [intervalometerModel getNotification];
    }
    
    //[[[self navigationController] tabBarController] tabBar].hidden = YES;
    
    interval.textAlignment = UITextAlignmentRight;
    interval.text =  [intervalData getIntervalStringParsed];
    
    shutterSpeed.textAlignment = UITextAlignmentRight;
    shutterSpeed.text = [intervalData getShutterStringParsed];
    
    [intervalometerModel startIntervalometer];
    

}

-(void) setIntervalText {
    
// remove
}

-(void) viewDidDisappear:(BOOL)animated {
    NSLog(@"trying to stop intervalometer");
    [intervalometerModel stopIntervalometer];
}

-(IBAction) stopButtonPressed {
    NSLog(@"Stop button pressed");
    //self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

-(void) notifyOfInterrupt:(NSString *) currentTime {
    NSLog(@"Time passed");
    durationTime.text = currentTime;

}

-(void) notifyOfInterruptToUpdateIntervalProgress:(float) percentage {
    [intervalProgress setProgress:percentage];
}

-(void) notifyOfInterruptToUpdatShutterProgress:(float) percentage {
    [shutterProgress setProgress:percentage];
}



-(void) notifyOfDurationEnd { 
    NSLog(@"Duration ended");
    [durationTime setHidden:true];
    unlimitedDuration.text = @"Duration Ended";
    [unlimitedDuration setHidden:false];
    [stopButton setTitle:@"Return" forState:0];
    
}

-(void) viewDidLoad {
    NSLog(@"IntervalometerCountdownVC did load");
    [navigation setHidesBackButton:true];
}

-(IBAction) testButtonPressed {
    NSLog(@"Intervalometer Count Down View Controller: Test button pressed");
    
    //hide the back button
    [navigation setHidesBackButton:true];
}



@end
