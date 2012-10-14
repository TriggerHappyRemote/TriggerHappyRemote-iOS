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
#define IPHONE_3_5 !( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IPHONE_4_0 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define TEST 0
#define PRODUCT 1

// The minimum amount of time that defines a numerical comparison operater (<)
// This is used for time, and this is value is portions of a second
#define TIMING_THREASHOLD .01

typedef enum  {
    SECONDS = 0,
    SUBSECONDS = 1
} PickerMode;

typedef enum  {
    BLUETOOTH_CAMAER_CONTOLLER = 0,
    AUDIO_CAMERA_CONTOLLER = 1
} CameraConrollerMode;

#endif
