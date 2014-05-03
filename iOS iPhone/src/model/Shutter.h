//
//  Shutter.h
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
//
//  Created by Kevin Harrington on 1/9/12.
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

@property (nonatomic, strong) Time *defaultShutterLength;

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
