//
//  HardwareManager.h
//  Trigger Happy
//
//  Created by Kevin Harrington on 10/14/12.
//
//

#import <Foundation/Foundation.h>

#define CAMERA_CONTROLLER_NEW 1
#define CAMERA_CONTROLLER_OLD 0

@class ICameraController;

@interface HardwareManager : NSObject

@property (nonatomic, strong) ICameraController* cameraController;

@property (nonatomic) BOOL hardwareDetection;

- (void) changeCameraControllerTo:(int)type;

- (int) cameraControllerType;

+ (HardwareManager *)getInstance;

@end
