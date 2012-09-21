//
//  AudioOuputController.h
//  Trigger Happy Remote  
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "ICameraController.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioOutputCameraController : ICameraController <AVAudioPlayerDelegate> {
    @private
    AVAudioPlayer *audioPlayer_033ms;
    AVAudioPlayer *audioPlayer_066ms;
    AVAudioPlayer *audioPlayer_125ms;
    AVAudioPlayer *audioPlayer_250ms;
    AVAudioPlayer *audioPlayer_500ms;
    AVAudioPlayer *audioPlayer_1s;
    AVAudioPlayer *audioPlayer_100ms;
    AVAudioPlayer *audioPlayer_blank_1s;
}

@end
