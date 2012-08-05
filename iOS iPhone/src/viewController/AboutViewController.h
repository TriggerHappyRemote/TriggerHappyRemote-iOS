//
//  MoreViewController.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *buyButton;

- (IBAction)learnMorePressed:(id)sender;

- (IBAction)buyButtonClicked:(id)sender;

@end
