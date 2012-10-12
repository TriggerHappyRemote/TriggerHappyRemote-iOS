//
//  AudioOutputCameraController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "ICameraController.h"
#import <AVFoundation/AVFoundation.h>

@class OpenALSynthesizer;

@interface AudioOutputCameraController : ICameraController <AVAudioPlayerDelegate> {
    @private
    AVAudioPlayer *audioPlayer_blank_1s;
    OpenALSynthesizer *synthesizer;
}

@end
