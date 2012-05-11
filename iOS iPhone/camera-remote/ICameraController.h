//
//  ICameraController.h
//  Trigger-Happy
//
//  Created by Kevin Harrington on 5/11/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Time.h"

@interface ICameraController : NSObject

- (void) fireCamera: (Time *) time;

// start an aribarty long signal to the shutter on the camera
- (void) fireButtonPressed;

// stop an aribarty long signal to the shutter on the camera
- (void) fireButtonDepressed;


@end
