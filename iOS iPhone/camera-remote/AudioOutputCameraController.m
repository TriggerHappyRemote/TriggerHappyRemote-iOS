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
@property (nonatomic) UInt32 outputSignalID;

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

@synthesize outputSignalID = _outputSignalID;
@synthesize s033msID = _s033msID, s067msID = _s067msID, s100msID = _s100msID, s125msID = _s125msID, s1sID = _s1sID, s250msID = _s250msID, s500msID = _s500msID;

NSTimer * totalShutterLength;
NSTimer * shutterInterval;

-(id) init {
	CFBundleRef mainBundle = CFBundleGetMainBundle();
	CFURLRef soundFileRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"100kHz_100ms", CFSTR("wav"), NULL);
	AudioServicesCreateSystemSoundID(soundFileRef, &_outputSignalID);
    
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
    [shutterInterval invalidate];
    [totalShutterLength invalidate];
}

#pragma PublicMethods
- (void) fireCamera: (Time *) time {    
    if([time milliseconds] == 33) {
        AudioServicesPlaySystemSound(self.s033msID);
    }
    else if([time milliseconds] == 67) {
        AudioServicesPlaySystemSound(self.s067msID);
    }
    else if([time milliseconds] == 125) {
        AudioServicesPlaySystemSound(self.s125msID);
    }
    else if([time milliseconds] == 250) {
        AudioServicesPlaySystemSound(self.s250msID);
    }
    else if([time milliseconds] == 500) {
        AudioServicesPlaySystemSound(self.s500msID);
    }
    else {
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
}

- (void) fireButtonPressed {
    [self startArbitraryAudioStream];
}
- (void) fireButtonDepressed {
    [self stopAudioStream];
}

@end
