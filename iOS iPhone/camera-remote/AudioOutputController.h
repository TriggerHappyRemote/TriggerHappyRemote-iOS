//
//  AudioOuputController.h
//  Trigger Happy, V1.0  
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Time.h"

@interface AudioOutputController : NSObject

@property (nonatomic) UInt32 outputSignalID;

- (void) fireCamera: (Time *) time;

- (void)fireButtonPressed;

- (void) fireButtonDepressed;






@end
