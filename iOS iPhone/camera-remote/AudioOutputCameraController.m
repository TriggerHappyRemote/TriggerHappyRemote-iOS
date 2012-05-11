//
//  AudioOuputController.m
//  Trigger Happy, V1.0  
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "AudioOutputCameraController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface AudioOutputCameraController() 
-(void) playAudio;
-(void) shutterIntervalInterrupt;
@end

@implementation AudioOutputCameraController

@synthesize outputSignalID = _outputSignalID;

NSTimer * totalShutterLength;
NSTimer * shutterInterval;

-(id) init {
    NSLog(@"init called for audio controller");
	CFBundleRef mainBundle = CFBundleGetMainBundle();
	CFURLRef soundFileRef;
	soundFileRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"100kHz_100ms", CFSTR("wav"), NULL);
	AudioServicesCreateSystemSoundID(soundFileRef, &_outputSignalID);    
    return self;
}

#pragma PrivateMethods
-(void) playAudio {
    NSLog(@"play audio");
    AudioServicesPlaySystemSound(self.outputSignalID);
}

-(void) startArbitraryAudioStream {
    [self playAudio];
    shutterInterval = [NSTimer scheduledTimerWithTimeInterval:.1
                                             target:self
                                           selector:@selector(playAudio)
                                           userInfo:nil
                                                      repeats:YES];
}

-(void) stopAudioStream {
    [shutterInterval invalidate];
    [totalShutterLength invalidate];
}

#pragma PublicMethods
- (void) fireCamera: (Time *) time {
    NSLog(@"Fire camera!");
    
    [self playAudio];
    shutterInterval = [NSTimer scheduledTimerWithTimeInterval:.1
                                                       target:self
                                                     selector:@selector(playAudio)
                                                     userInfo:nil
                                                      repeats:YES];
    
    totalShutterLength = [NSTimer scheduledTimerWithTimeInterval:[time totalTimeInSeconds]
                                                          target:self
                                                        selector:@selector(stopAudioStream)
                                                        userInfo:nil
                                                         repeats:NO];
}

- (void) fireButtonPressed {
    [self startArbitraryAudioStream];
}
- (void) fireButtonDepressed {
    [self stopAudioStream];
}

@end
