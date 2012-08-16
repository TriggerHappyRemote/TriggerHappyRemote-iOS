//
//  SingleShotViewController.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDataAccessViewController.h"

@interface SingleShotViewController : IDataAccessViewController

-(IBAction) fireTownDown;

-(IBAction) fireTownUp;

-(IBAction) pressHoldDidChange;

@property (nonatomic, retain) IBOutlet UIButton * fireButton;
@property (nonatomic, retain) IBOutlet UILabel * useInfoMessage;

@property (nonatomic, retain) IBOutlet UISegmentedControl * pressHoldSegment;

@property (strong, nonatomic) IBOutlet UILabel *fireButtonLabel;


@end
