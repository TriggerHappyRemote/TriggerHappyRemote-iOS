//
//  MoreViewController.h
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *buyButton;

- (IBAction)learnMorePressed:(id)sender;

- (IBAction)buyButtonClicked:(id)sender;

@end
