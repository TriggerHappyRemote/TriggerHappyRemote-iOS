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
#include "IntervalData.h"
#import "HardwareManager.h"
#import "OpenALSynthesizer.h"

@interface AudioOutputCameraController()
@property (nonatomic) BOOL background;
@property (nonatomic) BOOL audioPlaying;
@property (nonatomic) BOOL muteAudio;
@property (nonatomic) BOOL canPlay;
@property (nonatomic, retain) NSString *audioFile;
-(void) enteredBackground;
-(void) enteredForeground;
@end

@implementation AudioOutputCameraController

@synthesize background, audioPlaying, muteAudio, audioFile, canPlay;

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

    // enable backround proccessing remote control events
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    return self;
}

- (BOOL) canPlay {
    return [self isHardwareConnected] || ![HardwareManager getInstance].hardwareDetection;
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

#pragma PublicMethods
- (void) fireCamera: (Time *) time {
    if(self.canPlay) {
        synthesizer.hardwareConnected = YES;
        self.audioPlaying = YES;
        [NSTimer scheduledTimerWithTimeInterval:time.totalTimeInSeconds
                                         target:self
                                       selector:@selector(fireButtonDepressed)
                                       userInfo:nil
                                        repeats:NO];
        [synthesizer playSound:self.audioFile doesLoop:YES];
    }
}

- (void) fireButtonPressed {
    if(self.canPlay) {
        synthesizer.hardwareConnected = YES;
        self.audioPlaying = YES;
        [synthesizer playSound:self.audioFile doesLoop:YES];
    }
}

- (void) fireButtonDepressed {
    [synthesizer stopAllSounds];
    if(!self.background)
        synthesizer.hardwareConnected = NO;
    self.audioPlaying = NO;
}

- (bool)isHardwareConnected {
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
            return YES;
        }
        
    }
    return NO;    
}

-(void) pausePlayRemoteEventRecieved {
    self.muteAudio = !self.muteAudio;
    synthesizer.hardwareConnected = !self.muteAudio;

}

@end
