//
//  MoreViewController.h
//  camera-remote
//
//  Created by Kevin Harrington on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *buyButton;

- (IBAction)learnMorePressed:(id)sender;

- (IBAction)buyButtonClicked:(id)sender;

@end
