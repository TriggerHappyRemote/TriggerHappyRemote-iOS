//
//  IntervalometerViewController.m
//  Trigger Happy V1.0
//
//  Created by Kevin Harrington on 12/19/11.
//  Copyright (c) 2011 Trigger Happy, LLC. All rights reserved.
//

#import "IntervalometerViewController.h"
#import "AppDelegate.h"


@interface IntervalometerViewController()
-(void)loadButtons;
-(void) setButtonTitles;
@end

@implementation IntervalometerViewController 

@synthesize navigation;

@synthesize shutterSetButton, intervalSetButton, durationSetButton, hdrSetButton, brampingSetButton;

@synthesize shutterLabel, intervalLabel, durationLabel, settings;

IntervalData *intervalData;

-(void) viewWillAppear:(BOOL)animated {
    NSLog(@"View will appear ivc");
    
    
    AppDelegate * d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    intervalData = [d getIntervalData];
    
    // TODO: remove, idk what this does
    //[d setIntervalVC:self];
    
    [[[self navigationController] tabBarController] tabBar].hidden = NO;
    [navigation setHidesBackButton:true];
    [self loadButtons];
    [self.navigationController setNavigationBarHidden:NO animated:false]; 
    [self.settings setSelectedSegmentIndex:[[intervalData shutter] mode]];
}

-(void) viewDidLoad {
//    [navigation setHidesBackButton:true];
//    
//    AppDelegate * d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    intervalData = [d getIntervalData];
//    [d setIntervalVC:self];
}

-(void) loadButtons {
    
    switch ([[intervalData shutter] mode]) {
        case (HDR_MODE):
            [shutterSetButton setHidden:true];
            [brampingSetButton setHidden:true];
            [hdrSetButton setHidden:false];
            
            [shutterLabel setHidden:true];
            

            break;
        case (BRAMP):
            [shutterSetButton setHidden:true];
            [brampingSetButton setHidden:false];
            [hdrSetButton setHidden:true];
            
            [shutterLabel setHidden:true];

            break;
        default:
            [shutterSetButton setHidden:false];
            [brampingSetButton setHidden:true];
            [hdrSetButton setHidden:true];
            
            [shutterLabel setHidden:false];
            break;
        
    }
    
    [self setButtonTitles];

}

- (void) setButtonTitles {

    NSLog(@"set button titles");
    
    if([[intervalData interval] intervalEnabled]) {
        intervalLabel.text = [[[intervalData interval] time] toStringDownToSeconds];
    }
    else {
        intervalLabel.text = @"Off"; 
    }
    
    if([[intervalData shutter] mode] == STANDARD) {
        shutterLabel.text = [[intervalData shutter] getButtonData];
    }
    
    
    if([[intervalData duration] unlimitedDuration]) {
        durationLabel.text = @"Unlimited";
    }
    else {
        durationLabel.text = [[[intervalData duration] time] toStringDownToMinutes];
    }
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

-(IBAction) segmentSettingsChanged {
    NSLog(@"setting changed %i", settings.selectedSegmentIndex); 
    
    // remember: Standard = 0, hdr = 1, bramping = 2
    [[intervalData shutter] setMode:settings.selectedSegmentIndex];
    [self loadButtons];
    
}


@end
