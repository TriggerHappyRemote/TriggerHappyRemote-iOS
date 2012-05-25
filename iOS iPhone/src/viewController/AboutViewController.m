//
//  MoreViewController.m
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
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
