//
//  Bramper.h
//  Trigger Happy, V1.0
//
//  Created by Kevin Harrington on 4/27/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Time.h"
#import "Constants.h"
@interface Bramper : NSObject

@property (nonatomic, strong) Time * startShutterLength;
@property (nonatomic, strong) Time * endShutterLength;
@property (nonatomic) PickerMode pickerModeStart;
@property (nonatomic) PickerMode pickerModeStop;

- (NSString *) getStartShutterLabelText;
- (NSString *) getEndShutterLabelText;

@end
