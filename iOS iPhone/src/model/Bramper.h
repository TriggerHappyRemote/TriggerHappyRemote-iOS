//
//  Bramper.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "Constants.h"
@class Time;

@interface Bramper : NSObject

@property (nonatomic, strong) Time * startShutterLength;
@property (nonatomic, strong) Time * endShutterLength;
@property (nonatomic) PickerMode pickerModeStart;
@property (nonatomic) PickerMode pickerModeStop;

- (NSString *) getStartShutterLabelText;
- (NSString *) getEndShutterLabelText;

@end
