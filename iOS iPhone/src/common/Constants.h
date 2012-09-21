//
//  Constants.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#ifndef CONSTANTS_H
#define CONSTANTS_H

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

#define TEST 1
#define PRODUCT 0

typedef enum  {
    SECONDS = 0,
    SUBSECONDS = 1
} PickerMode;

typedef enum  {
    BLUETOOTH_CAMAER_CONTOLLER = 0,
    AUDIO_CAMERA_CONTOLLER = 1
} CameraConrollerMode;

#endif
