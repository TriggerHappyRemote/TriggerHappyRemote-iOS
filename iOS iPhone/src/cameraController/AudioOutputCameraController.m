//
//  LEGACYAudioOutputCameraController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "AudioOutputCameraController.h"
#import <AudioToolbox/AudioToolbox.h>
#include "TargetConditionals.h"
#import "ICameraController.h"
#include "Constants.h"


#import "OpenALSynthesizer.h"

@implementation AudioOutputCameraController

-(id) init {
    
    // init audio session with c callback block which allows us to get headphone data
    // to detect if headphones are plugged in or not
    AudioSessionInitialize (NULL, NULL, NULL, NULL);
    AudioSessionSetActive(true);
    
    // Allow playback even if Ring/Silent switch is on mute for AVAudioPlayer
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty (kAudioSessionProperty_AudioCategory,
                             sizeof(sessionCategory),&sessionCategory);
    // init av players
	NSError *error;
    
    // TODO
    /*
#if PRODUCT == 1
#elif TEST == 1
#else
    [NSException raise:@"Invalid constants definded in Constants.h. TEST or PRODUCT must be defined at 1"];
#endif
     */
    
    synthesizer = [[OpenALSynthesizer alloc] init];
    [synthesizer loadFile:@"20kHz_plus_1kHz_1s" doesLoop:true];

    
    // create an audio player for background proccesssing
    NSURL *url_blank_1 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/blank_test_1s.wav", [[NSBundle mainBundle] resourcePath]]];
        audioPlayer_blank_1s = [[AVAudioPlayer alloc] initWithContentsOfURL:url_blank_1 error:&error];
    [audioPlayer_blank_1s setVolume:0.0];
    [audioPlayer_blank_1s setDelegate:self];
    
    
    // enable backround proccessing
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    return self;
}

#pragma PrivateMethods


-(void) startArbitraryAudioStream {
    
}

-(void) stopAudioStream {
    
    [audioPlayer_blank_1s stop];
}

#pragma PublicMethods
- (void) fireCamera: (Time *) time {
    [NSTimer scheduledTimerWithTimeInterval:time.totalTimeInSeconds
                                     target:self
                                   selector:@selector(fireButtonDepressed)
                                   userInfo:nil
                                    repeats:NO];
    [synthesizer playSound:@"20kHz_plus_1kHz_1s" doesLoop:YES];
}

- (void) fireButtonPressed {
    [synthesizer playSound:@"20kHz_plus_1kHz_1s" doesLoop:YES];
}

- (void) fireButtonDepressed {
    [synthesizer pauseSound:@"20kHz_plus_1kHz_1s"];
}

- (bool)isHardwareConnected {
#if !(TARGET_IPHONE_SIMULATOR)
    UInt32 routeSize = sizeof (CFStringRef);
    CFStringRef route;
    
    OSStatus error = AudioSessionGetProperty (kAudioSessionProperty_AudioRoute,
                                              &routeSize,
                                              &route);
    
    //         Known values of route:
    //         * "Headset"
    //         * "Headphone"
    //         * "Speaker"
    //         * "SpeakerAndMicrophone"
    //         * "HeadphonesAndMicrophone"
    //         * "HeadsetInOut"
    //         * "ReceiverAndMicrophone"
    //         * "Lineout"
    //         *
    
    if (!error && (route != NULL)) {
        
        NSString* routeStr = (__bridge NSString*)route;
        
        NSRange headphoneRange = [routeStr rangeOfString : @"Head"];
        
        if (headphoneRange.location != NSNotFound) {
            return true;
        }
        
    }
    return false;
#endif
    // hardware is assumed connected in the iOS Simulator
    return true;
    
}

-(void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {    
    [audioPlayer_blank_1s play];
}

/* Allows to global control of the player on the iOS device
 I'm not sure if we want this
 
 //Make sure we can recieve remote control events
 - (BOOL)canBecomeFirstResponder {
 return YES;
 }
 
 - (void)remoteControlReceivedWithEvent:(UIEvent *)event {
 //if it is a remote control event handle it correctly
 if (event.type == UIEventTypeRemoteControl) {
 if (event.subtype == UIEventSubtypeRemoteControlPlay) {
 NSLog(@"play button pressed");
 //  [self playAudio];
 } else if (event.subtype == UIEventSubtypeRemoteControlPause) {
 NSLog(@"plause button pressed");
 // [self pauseAudio];
 } else if (event.subtype == UIEventSubtypeRemoteControlTogglePlayPause) {
 NSLog(@"toggle");
 //[self togglePlayPause];
 }
 }
 }
 
 */



@end
