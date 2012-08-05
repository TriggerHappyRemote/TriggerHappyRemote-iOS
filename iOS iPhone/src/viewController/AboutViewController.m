//
//  MoreViewController.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

@synthesize buyButton;

- (IBAction)buyButtonClicked:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.triggerhappyremote.com/Pages/TriggerHappy-Canon-DSLR-Remote/22724945_x8gMDh"]];
}



- (IBAction)learnMorePressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.triggerhappyremote.com/"]];
}
@end
