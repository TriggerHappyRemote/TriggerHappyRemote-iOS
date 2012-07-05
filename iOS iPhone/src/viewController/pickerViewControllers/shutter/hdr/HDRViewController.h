//
//  HDRViewController.h
//  camera-remote
//
//  Created by Kevin Harrington on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDRViewController : UIViewController {
    UILabel * exposureValueLabel;
    UILabel * numberOfShotsLabel;
    UILabel * shutterLengthLabel;
}

@property (strong, nonatomic) IBOutlet UILabel *exposureValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfShotsLabel;
@property (strong, nonatomic) IBOutlet UILabel *shutterLengthLabel;

@property (strong, nonatomic) IBOutlet UIImageView *centerEVTick;
@property (strong, nonatomic) IBOutlet UIImageView *pos1EVTick;
@property (strong, nonatomic) IBOutlet UIImageView *neg1EVTick;

@property (retain, nonatomic) IBOutlet UILabel *axis0Label;
@property (retain, nonatomic) IBOutlet UILabel *axis1Label;
@property (retain, nonatomic) IBOutlet UILabel *axis2Label;
@property (retain, nonatomic) IBOutlet UILabel *axis3Label;

@end
