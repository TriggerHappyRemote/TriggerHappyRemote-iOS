//
//  MoreViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"
#import "FaceDetectionViewController.h"

@implementation MoreViewController

@synthesize buyButton;

- (IBAction)buyButtonClicked:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.triggerhappyremote.com/Pages/TriggerHappy-Canon-DSLR-Remote/22724945_x8gMDh"]];
}



- (IBAction)learnMorePressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.triggerhappyremote.com/"]];
}
@end
