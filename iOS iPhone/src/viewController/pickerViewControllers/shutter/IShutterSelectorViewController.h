//
//  IShutterSelectorViewController.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ITimeSelectorViewController.h"

@interface IShutterSelectorViewController : ITimeSelectorViewController

@property (nonatomic, retain) NSString * infoMessage;
@property (nonatomic, retain) NSString * warningMessage;


@end
