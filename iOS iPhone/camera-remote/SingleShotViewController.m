//
//  SingleShotViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SingleShotViewController.h"
#import "Time.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>




@implementation SingleShotViewController

@synthesize useInfoMessage, fireButton;

NSTimer * timer;

-(void) viewDidAppear:(BOOL)animated {
    

}

-(IBAction) fireTownDown {
    NSLog(@"Fire touch down");   
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.1
                                                     target:self
                                                   selector:@selector(playAudio)
                                                   userInfo:nil
                                                    repeats:YES];
    
    [self playAudio];
}

-(IBAction) fireTownUp {
    NSLog(@"Fire touch up");
    [timer invalidate];
}

- (void) playAudio {
    NSLog(@"Playing audio??");
	CFBundleRef mainBundle = CFBundleGetMainBundle();
	CFURLRef soundFileRef;
	soundFileRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"100kHz_100ms", CFSTR("wav"), NULL);
	UInt32 soundID;
    
	AudioServicesCreateSystemSoundID(soundFileRef, &soundID);
	AudioServicesPlaySystemSound(soundID);
}

@end
