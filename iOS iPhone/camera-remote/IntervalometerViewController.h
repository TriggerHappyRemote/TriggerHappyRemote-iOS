//
//  IntervalometerViewController.h
//  camera-remote
//
//  Created by Kevin Harrington on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IntervalData.h"

@interface IntervalometerViewController : UIViewController

-(IBAction) startButtonPressed;

- (void) setButtonTitles;

@property (nonatomic, retain) IBOutlet UINavigationItem *navigation;
@property (nonatomic, retain) IBOutlet UIButton * durationSetButton;
@property (nonatomic, retain) IBOutlet UIButton * shutterSetButton;
@property (nonatomic, retain) IBOutlet UIButton * intervalSetButton;

@property (nonatomic, retain) IBOutlet UILabel * shutterLabel;
@property (nonatomic, retain) IBOutlet UILabel * intervalLabel;
@property (nonatomic, retain) IBOutlet UILabel * durationLabel;

@end
