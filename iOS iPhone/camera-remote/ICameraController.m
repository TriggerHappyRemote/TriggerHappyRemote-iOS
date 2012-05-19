//
//  ICameraController2.m
//  Trigger-Happy
//
//  Created by Kevin Harrington on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ICameraController.h"

@implementation ICameraController

- (void) fireCamera: (Time *) time {}

// start an aribarty long signal to the shutter on the camera
- (void) fireButtonPressed {}

// stop an aribarty long signal to the shutter on the camera
- (void) fireButtonDepressed {}

- (bool) isHardwareConnected {return false;}

@end
