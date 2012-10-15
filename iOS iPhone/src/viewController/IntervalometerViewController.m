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
#import "Constants.h"
#import "Shutter.h"
#import "Interval.h"
#import "IntervalDuration.h"


@interface IntervalometerViewController()
-(void)loadButtons;
-(void) setButtonTitles;
@end

@implementation IntervalometerViewController 


@synthesize navigation;

@synthesize shutterSetButton, intervalSetButton, durationSetButton, hdrSetButton, brampingSetButton;

@synthesize shutterLabel, intervalLabel, durationLabel, settings;

NSTimer * headPhoneChecker;

-(void) viewDidLoad {
    [super viewDidLoad];
    if(IDIOM == IPAD)
        infoViewController = [InfoViewController withLocationForPad:82 and:552];
    else
        infoViewController = [InfoViewController withLocationForPhone:0 and:187];

    [self.view addSubview:infoViewController.view];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // hack to tell if we in the single shot view
    //intervalData.interval.intervalEnabled = settings.numberOfSegments != 2;
    if(settings.numberOfSegments == 3) { //time lapse
        [IntervalData switchInstance:YES];
        //[intervalData constrainForTimeLapse];
    } else {
        [IntervalData switchInstance:NO];
        [IntervalData getInstance].interval.intervalEnabled = NO;
    }
    
    [[[self navigationController] tabBarController] tabBar].hidden = NO;
    [navigation setHidesBackButton:YES];
    [self loadButtons];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.settings setSelectedSegmentIndex:[[[IntervalData getInstance] shutter] mode]];
}

-(void) loadButtons {
    switch ([[[IntervalData getInstance] shutter] mode]) {
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

    
    
    if([[[IntervalData getInstance] interval] intervalEnabled]) {
        intervalLabel.text = [[[IntervalData getInstance] interval] getButtonData];
    }
    else {
        intervalLabel.text = @"Off"; 
    }
    
    if([[[IntervalData getInstance] shutter] mode] == STANDARD) {
        shutterLabel.text = [[[IntervalData getInstance] shutter] getButtonData];
    } 
    
    if([[[IntervalData getInstance] duration] unlimitedDuration]) {
        durationLabel.text = @"Unlimited";
    }
    else {
        durationLabel.text = [[[[IntervalData getInstance] duration] time] toStringDownToMinutes];
    }
}

- (IBAction)startButtonPressedSingleShot:(id)sender {
    [IntervalData getInstance].interval.intervalEnabled = NO;
    [self startButtonPressed];
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
    [[[IntervalData getInstance] shutter] setMode:settings.selectedSegmentIndex];
    
    // if in normal mode, set defual mode to auto so users don't get too confused with advanced
    // settings like manual
    [IntervalData getInstance].shutter.bulbMode = (settings.selectedSegmentIndex != 0);
    
    if(settings.selectedSegmentIndex == 0) {
        
    }
    else if(settings.selectedSegmentIndex == 1) { // duration
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Bulb Mode Required" message:@"Please put your camera in bulb." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }
    else { // bramp
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Bulb Mode Required" message:@"Please put your camera in bulb." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

        // you can't bramp unless there's a finite time in which the intervalometer
        // will bramp
        [[[IntervalData getInstance] duration] setUnlimitedDuration:NO];
    }
    [self loadButtons];
    
}


- (void)viewDidUnload {
    [super viewDidUnload];
}

@end
