//
//  IDataAccessViewController.h
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntervalData.h"
#import "ICameraController.h"
#import "InfoViewController.h"

@interface IDataAccessViewController : UIViewController {    
    InfoViewController * infoViewController;
    NSTimer * hardwareChecker;
    IntervalData * intervalData;
    ICameraController * cameraController;
}


@property (nonatomic) bool visible;


-(void) hardwareCheck;


@end
