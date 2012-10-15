//
//  IDataAccessViewController.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntervalData.h"
#import "ICameraController.h"
#import "InfoViewController.h"

@interface IDataAccessViewController : UIViewController {    
    InfoViewController * infoViewController;
    NSTimer * hardwareChecker;
    ICameraController * cameraController;
}


@property (nonatomic) bool visible;


-(void) hardwareCheck;


@end
