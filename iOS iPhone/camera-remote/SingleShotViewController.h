//
//  SingleShotViewController.h
//  camera-remote
//
//  Created by Kevin Harrington on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SingleShotViewController : UIViewController

-(IBAction) fireTownDown;

-(IBAction) fireTownUp;

@property (nonatomic, retain) IBOutlet UIButton * fireButton;
@property (nonatomic, retain) IBOutlet UILabel * useInfoMessage;

-(void) playAudio;

@end
