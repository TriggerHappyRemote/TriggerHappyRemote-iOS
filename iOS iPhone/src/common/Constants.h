//
//  Constants.h
//  camera-remote
//
//  Created by Kevin Harrington on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef CONSTANTS_H
#define CONSTANTS_H

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

typedef enum  {
    SECONDS = 0,
    SUBSECONDS = 1
} PickerMode;

typedef enum  {
    BLUETOOTH_CAMAER_CONTOLLER = 0,
    AUDIO_CAMERA_CONTOLLER = 1
} CameraConrollerMode;

#endif
