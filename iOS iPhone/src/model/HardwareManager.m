//
//  HardwareManager.m
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
//  Created by Kevin Harrington on 10/14/12.
//
//

#import "HardwareManager.h"
#import "AudioOutputCameraController.h"
#import "ICameraController.h"
#import "LEGACYAudioOutputCameraController.h"


static HardwareManager *_globalInstance= nil;

@interface HardwareManager ()
@property (nonatomic, retain) ICameraController *controller_new;
@property (nonatomic, retain) ICameraController *controller_old;
@end

@implementation HardwareManager

@synthesize cameraController = _cameraController;
@synthesize hardwareDetection;
@synthesize controller_old, controller_new;

+ (HardwareManager *)getInstance {
    static bool initialized = NO;
    if (!initialized) {
        _globalInstance = [[self alloc] init];
        initialized = YES;
    }
    return _globalInstance;
}

-(id) init {
    controller_new = [AudioOutputCameraController new];
    controller_old = [LEGACYAudioOutputCameraController new];
    
    hardwareDetection = YES;
    _cameraController = controller_new;
    return self;
}

- (void) changeCameraControllerTo:(int)type {
    if(type == CAMERA_CONTROLLER_NEW) {
        _cameraController = self.controller_new;
    } else {
        _cameraController = self.controller_old;
    }
}

- (int) cameraControllerType {
    if([_cameraController class] == [AudioOutputCameraController class]) {
        return CAMERA_CONTROLLER_NEW;
    }
    return CAMERA_CONTROLLER_OLD;
}


@end
