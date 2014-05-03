//
//  LEGACYAudioOutputCameraController.m
//  Copyright (c) 2014 Kevin Harrington
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  Created by Kevin Harrington on 1/9/12.
//  
//

#import "LEGACYAudioOutputCameraController.h"
#import <AudioToolbox/AudioToolbox.h>
#include "TargetConditionals.h"
#import "ICameraController.h"
#include "Constants.h"

@implementation LEGACYAudioOutputCameraController

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
    
#if PRODUCT == 1
    NSURL *url_033 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_033ms.wav", [[NSBundle mainBundle] resourcePath]]];
    NSURL *url_066 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_067ms.wav", [[NSBundle mainBundle] resourcePath]]];
    NSURL *url_125 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_125ms.wav", [[NSBundle mainBundle] resourcePath]]];
    NSURL *url_250 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_250ms.wav", [[NSBundle mainBundle] resourcePath]]];
    NSURL *url_500 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_500ms.wav", [[NSBundle mainBundle] resourcePath]]];
    NSURL *url_1 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_1s.wav", [[NSBundle mainBundle] resourcePath]]];
    NSURL *url_100 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_100ms.wav", [[NSBundle mainBundle] resourcePath]]];
#elif TEST == 1
    NSURL *url_033 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_plus_1kHz_033ms.wav", [[NSBundle mainBundle] resourcePath]]];
    NSURL *url_066 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_plus_1kHz_067ms.wav", [[NSBundle mainBundle] resourcePath]]];
    NSURL *url_125 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_plus_1kHz_125ms.wav", [[NSBundle mainBundle] resourcePath]]];
    NSURL *url_250 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_plus_1kHz_250ms.wav", [[NSBundle mainBundle] resourcePath]]];
    NSURL *url_500 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_plus_1kHz_500ms.wav", [[NSBundle mainBundle] resourcePath]]];
    NSURL *url_1 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_plus_1kHz_1s.wav", [[NSBundle mainBundle] resourcePath]]];
    NSURL *url_100 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_plus_1kHz_100ms.wav", [[NSBundle mainBundle] resourcePath]]];
#else
    [NSException raise:@"Invalid constants definded in Constants.h. TEST or PRODUCT must be defined at 1"];
#endif

    NSURL *url_blank_1 = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/blank_test_1s.wav", [[NSBundle mainBundle] resourcePath]]];
    
	audioPlayer_033ms = [[AVAudioPlayer alloc] initWithContentsOfURL:url_033 error:&error];
    audioPlayer_066ms = [[AVAudioPlayer alloc] initWithContentsOfURL:url_066 error:&error];
    audioPlayer_125ms = [[AVAudioPlayer alloc] initWithContentsOfURL:url_125 error:&error];
    audioPlayer_250ms = [[AVAudioPlayer alloc] initWithContentsOfURL:url_250 error:&error]; 
    audioPlayer_500ms = [[AVAudioPlayer alloc] initWithContentsOfURL:url_500 error:&error];
    audioPlayer_1s = [[AVAudioPlayer alloc] initWithContentsOfURL:url_1 error:&error];
    audioPlayer_100ms = [[AVAudioPlayer alloc] initWithContentsOfURL:url_100 error:&error];
    audioPlayer_blank_1s = [[AVAudioPlayer alloc] initWithContentsOfURL:url_blank_1 error:&error];

    
    [audioPlayer_033ms setVolume:1.0];
    [audioPlayer_066ms setVolume:1.0];
    [audioPlayer_125ms setVolume:1.0];
    [audioPlayer_250ms setVolume:1.0];
    [audioPlayer_500ms setVolume:1.0];
    [audioPlayer_1s setVolume:1.0];
    [audioPlayer_100ms setVolume:1.0];
    [audioPlayer_blank_1s setVolume:0.0];
    
    [audioPlayer_033ms setDelegate:self];
    [audioPlayer_066ms setDelegate:self];
    [audioPlayer_125ms setDelegate:self];
    [audioPlayer_250ms setDelegate:self];
    [audioPlayer_500ms setDelegate:self];
    [audioPlayer_1s setDelegate:self];
    [audioPlayer_100ms setDelegate:self];
    [audioPlayer_blank_1s setDelegate:self];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    return self;
}

#pragma PrivateMethods


-(void) startArbitraryAudioStream {
    [audioPlayer_100ms setVolume:1.0];
    audioPlayer_100ms.numberOfLoops = -1;
    [audioPlayer_100ms play];
}


-(void) stopAudioStream {
    [audioPlayer_033ms stop];
    [audioPlayer_066ms stop];
    [audioPlayer_125ms stop];
    [audioPlayer_250ms stop];
    [audioPlayer_500ms stop];
    [audioPlayer_1s stop];
    [audioPlayer_100ms stop];
    [audioPlayer_blank_1s stop];
}

#pragma PublicMethods
- (void) fireCamera: (Time *) time {
    // Do not play audio is "headphones" (i.e. the Trigger Happy
    // cable/ unit) are not plugged in because
    // 1) dont want to burden users with uneccessary sounds
    // 2) violotes Apple's HIG if it's in silient
    //if(self.isHardwareConnected) {
        
        // if the shutter length (time) is less than 1 second,
        // we play one file instead of looping to get a more accurate
        // audio playback length
        if([time totalTimeInSeconds] == .033) {
            [audioPlayer_033ms play];
        }
        else if([time totalTimeInSeconds] == .067) {
            [audioPlayer_066ms play];
        }
        else if([time totalTimeInSeconds] == .125) {

            [audioPlayer_125ms play];
        }
        else if([time totalTimeInSeconds] == .250) {

            [audioPlayer_250ms play];
        }
        else if([time totalTimeInSeconds] == .500) {

            [audioPlayer_500ms play];
        }
        else {
            
            // if time is great than a second, we set the number of loops
            // to the number of seconds then play a 1 second file n time,
            // where n = the integer number of seconds
            if([time totalTimeInSeconds] - 1 >= 0) {
                audioPlayer_1s.numberOfLoops = (int)[time totalTimeInSeconds] - 1;
            }
            else {
                audioPlayer_1s.numberOfLoops = 0;
            }
            
            [audioPlayer_1s play];
        }
    //}
}

- (void) fireButtonPressed {
    //if(self.isHardwareConnected) {
        [self startArbitraryAudioStream];
    //}
}

- (void) fireButtonDepressed {
    [self stopAudioStream];
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

-(void) pausePlayRemoteEventRecieved {};


@end
