//
//  HardwareManager.m
//  Trigger Happy
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
