//
//  Bramper.h
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
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
