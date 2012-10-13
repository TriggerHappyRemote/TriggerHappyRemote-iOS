//
//  BluetoothCameraController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "BluetoothCameraController.h"

@implementation BluetoothCameraController

- (void) fireCamera: (Time *) time {}

// start an aribarty long signal to the shutter on the camera
- (void) fireButtonPressed {}

// stop an aribarty long signal to the shutter on the camera
- (void) fireButtonDepressed {}

- (bool) isHardwareConnected {return false;}

-(void) pausePlayRemoteEventRecieved {}

@end
