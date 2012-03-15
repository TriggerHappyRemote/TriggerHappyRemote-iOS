//
//  SingleShotViewController.h
//  camera-remote
//
//  Created by Kevin Harrington on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleShotViewController : UIViewController {
    UILabel *useInfoMessage;
    UIButton *fireButton;
}

-(void) fireButtonPressedOnce;

-(void) fireButtonHeld;

-(IBAction) fireTownDown;

-(IBAction) fireTownUp;

@property (nonatomic, retain) IBOutlet UIButton * fireButton;
@property (nonatomic, retain) IBOutlet UILabel * useInfoMessage;

@end
