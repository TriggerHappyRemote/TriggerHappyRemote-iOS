//
//  AudioController.h
//  KevinCoreAudioHelloWord
//
//  Created by Kevin Harrington on 10/3/12.
//  Copyright (c) 2012 Kevin Harrington. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "CAStreamBasicDescription.h"

@interface AudioController : NSObject {
    
    // Audio Graph Members
	AUGraph   mGraph;
	AudioUnit mMixer;
    
	// Audio Stream Descriptions
	CAStreamBasicDescription outputCASBD;
    
	// Sine Wave Phase marker
	double sinPhase;
}

- (void)initializeAUGraph;
- (void)startAUGraph;
- (void)stopAUGraph;

@property (nonatomic) float hertz;
@end