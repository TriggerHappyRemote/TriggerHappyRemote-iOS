//
//  Shutter.h
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "Time.h"
#import "HDR.h"
#import "Bramper.h"
#import "Constants.h"

@interface Shutter : NSObject

typedef enum  {
    STANDARD = 0,
    HDR_MODE = 1,
    BRAMP = 2
} IntervalometerMode;


@property (nonatomic) IntervalometerMode mode;

// standard:
@property (nonatomic, strong) Time* startLength;
@property (nonatomic, strong) Time* currentLength;

@property (nonatomic) bool bulbMode;

// HDR:
@property (nonatomic, strong) HDR* hdr;

// Brapming:
@property (nonatomic, strong) Bramper* bramper;

@property (nonatomic) PickerMode pickerMode;


-(NSString*) getButtonData;

-(Time*) getMaxTime;

-(void) initializeCurrentLength;

- (NSMutableArray *) getShutterLengths;

@end
