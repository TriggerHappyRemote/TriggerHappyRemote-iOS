//
//  AudioOuputController.m
//  Trigger Happy, V1.0  
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "AudioOutputController.h"
#import <AudioToolbox/AudioToolbox.h>


//@interface AudioOutputController() 
//-(void) playAudio;
//-(void) startAudioStream: (NSTimeInterval) seconds;
//-(void) startArbitraryAudioStream;
//-(void) stopAudioStream;
//@end

@interface AudioOutputController() 
-(void) playAudio;
-(void) shutterIntervalInterrupt;
@end

@implementation AudioOutputController

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

//pragma PrivateMethods
-(void) playAudio {
    NSLog(@"play audio");
    AudioServicesPlaySystemSound(self.outputSignalID);
}

-(void) startAudioStream: (NSTimeInterval) seconds {
        // TODO
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

//pragma PublicMethods
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
    NSLog(@"Fire button pressed******");
    [self startArbitraryAudioStream];
}
- (void) fireButtonDepressed {
    NSLog(@"Fire button depressed");
    [self stopAudioStream];
}

- (void) abortShutter {
    [self stopAudioStream];
}

@end
