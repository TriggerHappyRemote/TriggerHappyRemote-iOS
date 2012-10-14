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

@interface AudioOutputCameraController()
@property (nonatomic) BOOL background;
@property (nonatomic) BOOL audioPlaying;
@property (nonatomic) BOOL muteAudio;
@property (nonatomic, retain) NSString *audioFile;
-(void) enteredBackground;
-(void) enteredForeground;
@end

@implementation AudioOutputCameraController

@synthesize background, audioPlaying, muteAudio, audioFile;

-(id) init {
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    // add listener
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(enteredBackground)
                                                 name: @"didEnterBackground"
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(enteredForeground)
                                                 name: @"didEnterForeground"
                                               object: nil];
    
    self.background = NO;
    self.audioPlaying = NO;
    self.muteAudio = NO;
    
    // init audio session with c callback block which allows us to get headphone data
    // to detect if headphones are plugged in or not
    AudioSessionInitialize (NULL, NULL, NULL, NULL);
    AudioSessionSetActive(true);
    
    // Allow playback even if Ring/Silent switch is on mute for AVAudioPlayer
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty (kAudioSessionProperty_AudioCategory, sizeof(sessionCategory),&sessionCategory);
    
    // init av players
	NSError *error;
    
    // TODO
    #if PRODUCT == 1
        self.audioFile = @"20kHz_1s";
    #elif TEST == 1
        self.audioFile = @"20kHz_plus_1kHz_1s";
    #else
    [NSException raise:@"Invalid constants definded in Constants.h. TEST or PRODUCT must be defined at 1"];
    #endif
    
    
    synthesizer = [[OpenALSynthesizer alloc] init];

    [synthesizer loadFile:self.audioFile doesLoop:YES];

    
    // create an audio player for background proccesssing
    NSURL *url_blank_1 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/blank_test_1s.wav", [[NSBundle mainBundle] resourcePath]]];
    
    audioPlayer_blank_1s = [[AVAudioPlayer alloc] initWithContentsOfURL:url_blank_1 error:&error];
    [audioPlayer_blank_1s setVolume:0.0];
    [audioPlayer_blank_1s setDelegate:self];
    
    
    // enable backround proccessing remote control events
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    return self;
}



#pragma PrivateMethods

-(void) enteredBackground {
    synthesizer.hardwareConnected = YES;
    self.background = YES;
}

-(void) enteredForeground {
    if(!self.audioPlaying)
        synthesizer.hardwareConnected = NO;
    self.background = NO;
}

-(void) startArbitraryAudioStream {
    
}

-(void) stopAudioStream {
    
    [audioPlayer_blank_1s stop];
}

#pragma PublicMethods
- (void) fireCamera: (Time *) time {
    synthesizer.hardwareConnected = YES;
    self.audioPlaying = YES;
    [NSTimer scheduledTimerWithTimeInterval:time.totalTimeInSeconds
                                     target:self
                                   selector:@selector(fireButtonDepressed)
                                   userInfo:nil
                                    repeats:NO];
    [synthesizer playSound:self.audioFile doesLoop:YES];
}

- (void) fireButtonPressed {
    synthesizer.hardwareConnected = YES;
    self.audioPlaying = YES;
    [synthesizer playSound:self.audioFile doesLoop:YES];
}

- (void) fireButtonDepressed {
    [synthesizer pauseSound:self.audioFile];
    if(!self.background)
        synthesizer.hardwareConnected = NO;
    self.audioPlaying = NO;
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

-(void) pausePlayRemoteEventRecieved {
    self.muteAudio = !self.muteAudio;
    synthesizer.hardwareConnected = !self.muteAudio;

}

@end
