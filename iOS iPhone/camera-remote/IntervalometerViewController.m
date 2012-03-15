//
//  IntervalometerViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "IntervalometerViewController.h"
#import "AppDelegate.h"


@implementation IntervalometerViewController

@synthesize navigation;

@synthesize shutterSetButton, intervalSetButton, durationSetButton, shutterLabel, intervalLabel, durationLabel;

IntervalData *intervalData;

-(void) viewWillAppear:(BOOL)animated {
    NSLog(@"View will appear ivc");
    
    [[[self navigationController] tabBarController] tabBar].hidden = NO;
    [navigation setHidesBackButton:true];
    [self setButtonTitles];
    [self.navigationController setNavigationBarHidden:NO animated:false];    

}

-(void) viewDidLoad {
    [navigation setHidesBackButton:true];
    
    AppDelegate * d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    intervalData = [d getIntervalData];
    [d setIntervalVC:self];
}

- (void) setButtonTitles {

    intervalLabel.text = [intervalData getIntervalStringParsed];
    
    shutterLabel.text = [intervalData getShutterStringParsed];
    
    durationLabel.text = [intervalData getDurationStringParsedForCountDown];
    //set 'setter button' titles
    /*
    [shutterSetButton setTitle:@"Shutter Speed: Auto **" forState:0];
    [intervalSetButton setTitle:[[NSString alloc] initWithFormat:@"Interval: %i h %i m %i s", 
                                 [intervalData getIntervalHours], [intervalData getIntervalMinutes], 
                                 [intervalData getIntervalSeconds]] forState:0];
    if(![intervalData isAutoShutter]) {
        [shutterSetButton setTitle:[[NSString alloc] initWithFormat:@"Shutter: %i h %i m %i s",
                                [intervalData getShutterHours], [intervalData getShutterMinutes], 
                                [intervalData getShutterSeconds]] forState:0];
    }
    else {
        [shutterSetButton setTitle:[[NSString alloc] initWithFormat:@"Shutter: Auto"] forState:0];
    }


    [durationSetButton setTitle:[intervalData getDurationStringParsed] forState:0];*/

}

-(IBAction) startButtonPressed {
    NSLog(@"startButtonPressed");
    //self.hidesBottomBarWhenPushed = YES;
    
    //IntervalometerCountDownViewController *myController = [[IntervalometerCountDownViewController alloc]init]; 
    //myController.hidesBottomBarWhenPushed = YES;
    //[self.navigationController pushViewController:myController animated:YES];
    
    
}

@end
