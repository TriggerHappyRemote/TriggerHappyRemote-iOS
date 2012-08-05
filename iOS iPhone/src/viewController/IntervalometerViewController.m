//
//  IntervalometerViewController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "IntervalometerViewController.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>




@interface IntervalometerViewController()
-(void)loadButtons;
-(void) setButtonTitles;
@end

@implementation IntervalometerViewController 


@synthesize navigation;

@synthesize shutterSetButton, intervalSetButton, durationSetButton, hdrSetButton, brampingSetButton;

@synthesize shutterLabel, intervalLabel, durationLabel, settings;

IntervalData *intervalData;
NSTimer * headPhoneChecker;

-(void) viewDidLoad {
    [super viewDidLoad];
    if(IDIOM == IPAD)
        infoViewController = [InfoViewController withLocationForPad:82 and:552];
    else
        infoViewController = [InfoViewController withLocationForPhone:0 and:187];

    [self.view addSubview:infoViewController.view];
    AppDelegate * d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    intervalData = [d getIntervalData];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:false];
    [[[self navigationController] tabBarController] tabBar].hidden = NO;
    [navigation setHidesBackButton:true];
    [self loadButtons];
    [self.navigationController setNavigationBarHidden:NO animated:false]; 
    [self.settings setSelectedSegmentIndex:[[intervalData shutter] mode]];
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
    intervalLabel.textAlignment = UITextAlignmentRight;
    durationLabel.textAlignment = UITextAlignmentRight;
    shutterLabel.textAlignment = UITextAlignmentRight;

    
    
    if([[intervalData interval] intervalEnabled]) {
        intervalLabel.text = [[intervalData interval] getButtonData];
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
}

-(IBAction) startButtonPressed {
    if([cameraController isHardwareConnected]) {
        MPMusicPlayerController *iPod = [MPMusicPlayerController iPodMusicPlayer];
        float volumeLevel = iPod.volume;
        if(volumeLevel < 1.0) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Volume Too Low" message:@"Turn the volume to max, so Trigger Happy will work" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];        
        }
    }
    else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Trigger Happy Not Connected" message:@"Plug Trigger Happy in and turn the volume to max" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show]; 
    }
}

-(IBAction) segmentSettingsChanged {    
    // remember: Standard = 0, hdr = 1, bramping = 2
    [[intervalData shutter] setMode:settings.selectedSegmentIndex];
    
    // you can't bramp unless there's a finite time in which the intervalometer
    // will bramp
    if(settings.selectedSegmentIndex == 2) {
        [[intervalData duration] setUnlimitedDuration:false];
    }
    [self loadButtons];
    
}


- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
