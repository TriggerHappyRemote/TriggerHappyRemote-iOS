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

@interface IDataAccessViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UIImageView *warningBackground;

@property (strong, nonatomic) NSTimer * hardwareChecker;

@property (strong, nonatomic) IntervalData * intervalData;
@property (strong, nonatomic) ICameraController * cameraController;

-(void) hardwareCheck;


@end
