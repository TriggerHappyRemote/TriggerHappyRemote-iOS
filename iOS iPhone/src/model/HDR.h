//
//  HDR.h
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
#import "Constants.h"

@interface HDR : NSObject

// number of shots
@property (nonatomic) int numberOfShots;

// ev interval
@property (nonatomic) double evInterval;

// base shutter speed
@property (nonatomic, strong) Time* baseShutterSpeed;

// time between each shot
@property (nonatomic) NSTimeInterval shutterGap;


// TODO: DO I need this?
@property (nonatomic) bool bulb;

-(NSString*) getButtonData;

-(NSTimeInterval) getMaxShutterLength;

@property (nonatomic) PickerMode pickerMode;


- (NSMutableArray *) getShutterLengths;

- (NSTimeInterval) maxTimeBetweenShots;

@end
