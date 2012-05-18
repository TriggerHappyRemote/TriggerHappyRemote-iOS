//
//  AudioOuputController.m
//  Trigger Happy, V1.0  
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "AudioOutputCameraController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioOutputCameraController() 

@property (nonatomic) UInt32 s033msID;
@property (nonatomic) UInt32 s067msID;
@property (nonatomic) UInt32 s100msID;
@property (nonatomic) UInt32 s125msID;
@property (nonatomic) UInt32 s250msID;
@property (nonatomic) UInt32 s500msID;
@property (nonatomic) UInt32 s1sID;

-(void) playAudio;
//-(void) shutterIntervalInterrupt;
@end

@implementation AudioOutputCameraController

@synthesize s033msID = _s033msID, s067msID = _s067msID, s100msID = _s100msID, s125msID = _s125msID, s1sID = _s1sID, s250msID = _s250msID, s500msID = _s500msID;

NSTimer * totalShutterLength;
NSTimer * shutterInterval;
AVAudioPlayer *audioPlayer;

-(id) init {
    // init av player
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/20kHz_plus_1kHz_1s.wav", [[NSBundle mainBundle] resourcePath]]];
    
	NSError *error;
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [audioPlayer setVolume:1.0];
    
	if (audioPlayer == nil)
		NSLog(@"Error! %@", [error description]);
    
	CFBundleRef mainBundle = CFBundleGetMainBundle();    

    
    //CFURLRef soundFileRef1 = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"20kHz_033ms", CFSTR("wav"), NULL);
    CFURLRef soundFileRef1 = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"20kHz_plus_1kHz_033ms", CFSTR("wav"), NULL);
	AudioServicesCreateSystemSoundID(soundFileRef1, &_s033msID);
    
    
    
    //CFURLRef soundFileRef2 = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"20kHz_067ms", CFSTR("wav"), NULL);
    CFURLRef soundFileRef2 = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"20kHz_plus_1kHz_067ms", CFSTR("wav"), NULL);

	AudioServicesCreateSystemSoundID(soundFileRef2, &_s067msID);
    
    //CFURLRef soundFileRef3 = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"20kHz_100ms", CFSTR("wav"), NULL);
    CFURLRef soundFileRef3 = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"20kHz_plus_1kHz_100ms", CFSTR("wav"), NULL);

	AudioServicesCreateSystemSoundID(soundFileRef3, &_s100msID);
    
    //CFURLRef soundFileRef4 = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"20kHz_125ms", CFSTR("wav"), NULL);
    CFURLRef soundFileRef4 = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"20kHz_plus_1kHz_125ms", CFSTR("wav"), NULL);

	AudioServicesCreateSystemSoundID(soundFileRef4, &_s125msID);
    
    //CFURLRef soundFileRef5 = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"20kHz_250ms", CFSTR("wav"), NULL);
    CFURLRef soundFileRef5 = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"20kHz_plus_1kHz_250ms", CFSTR("wav"), NULL);

	AudioServicesCreateSystemSoundID(soundFileRef5, &_s250msID);
    
    //CFURLRef soundFileRef6 = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"20kHz_500ms", CFSTR("wav"), NULL);
    CFURLRef soundFileRef6 = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"20kHz_plus_1kHz_500ms", CFSTR("wav"), NULL);

	AudioServicesCreateSystemSoundID(soundFileRef6, &_s500msID);
    
    //CFURLRef soundFileRef7 = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"20kHz_1s", CFSTR("wav"), NULL);
    CFURLRef soundFileRef7 = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"20kHz_plus_1kHz_1s", CFSTR("wav"), NULL);

	AudioServicesCreateSystemSoundID(soundFileRef7, &_s1sID);
    
    return self;
}

#pragma PrivateMethods
-(void) playAudio {
    AudioServicesPlaySystemSound(self.s125msID);
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
    [audioPlayer stop];
    [shutterInterval invalidate];
    [totalShutterLength invalidate];
}

#pragma PublicMethods
- (void) fireCamera: (Time *) time {
    
    if([time totalTimeInSeconds] == .33) {
        AudioServicesPlaySystemSound(self.s033msID);
    }
    else if([time totalTimeInSeconds] == .67) {
        AudioServicesPlaySystemSound(self.s067msID);
    }
    else if([time totalTimeInSeconds] == .125) {
        AudioServicesPlaySystemSound(self.s125msID);
    }
    else if([time totalTimeInSeconds] == .250) {
        AudioServicesPlaySystemSound(self.s250msID);
    }
    else if([time totalTimeInSeconds] == .500) {
        AudioServicesPlaySystemSound(self.s500msID);
    }
    else {
        
        if([time totalTimeInSeconds] - 1 >= 0) {
            audioPlayer.numberOfLoops = (int)[time totalTimeInSeconds] - 1;
        }
        else {
            audioPlayer.numberOfLoops = 0;
        }
        NSLog(@"Total time in seconds: %i", [audioPlayer numberOfLoops]);
        
        [audioPlayer play];
        
        
        /*[self playAudio];
        shutterInterval = [NSTimer scheduledTimerWithTimeInterval:.1
                                                           target:self
                                                         selector:@selector(playAudio)
                                                         userInfo:nil
                                                          repeats:YES];
        
        totalShutterLength = [NSTimer scheduledTimerWithTimeInterval:[time totalTimeInSeconds]
                                                              target:self
                                                            selector:@selector(stopAudioStream)
                                                            userInfo:nil
                                                             repeats:NO];*/
    }
}

- (void) fireButtonPressed {
    [self startArbitraryAudioStream];
}
- (void) fireButtonDepressed {
    [self stopAudioStream];
}

@end
