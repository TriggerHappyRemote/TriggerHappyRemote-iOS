//
//  SingleShotViewController.h
//  camera-remote
//
//  Created by Kevin Harrington on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "AudioOutputController.h"


@interface SingleShotViewController : UIViewController

-(IBAction) fireTownDown;

-(IBAction) fireTownUp;

-(IBAction) pressHoldDidChange;

@property (nonatomic, retain) IBOutlet UIButton * fireButton;
@property (nonatomic, retain) IBOutlet UILabel * useInfoMessage;

@property (nonatomic, retain) IBOutlet UISegmentedControl * pressHoldSegment;

@property (strong, nonatomic) IBOutlet UILabel *fireButtonLabel;

@end
