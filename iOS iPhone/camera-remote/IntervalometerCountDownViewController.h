//
//  IntervalometerCountDownViewController.h
//  camera-remote
//
//  Created by Kevin Harrington on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntervalometerCountDownViewController : UIViewController {
    UINavigationItem * navigation;
    UIButton * stopButton;
    
    UILabel * unlimitedDuration;
    UILabel * durationTime;
    UILabel * shutterSpeed;
    UILabel * interval;
    
    UIProgressView * intervalProgress;
    UIProgressView * shutterProgress;
    UIImageView * imageView;


}


-(IBAction) stopButtonPressed;

-(IBAction) testButtonPressed;

-(void) notifyOfInterrupt:(NSString *) currentTime;

-(void) notifyOfInterruptToUpdateIntervalProgress:(float) percentage;

-(void) notifyOfInterruptToUpdatShutterProgress:(float) percentage;


-(void) notifyOfDurationEnd;

-(void) setIntervalText;


@property (nonatomic, retain) IBOutlet UINavigationItem *navigation;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;

@property (nonatomic, retain) IBOutlet UILabel *unlimitedDuration;
@property (nonatomic, retain) IBOutlet UILabel *durationTime;
@property (nonatomic, retain) IBOutlet UILabel *shutterSpeed;
@property (nonatomic, retain) IBOutlet UILabel *interval;
@property (nonatomic, retain) IBOutlet UIProgressView * intervalProgress;
@property (nonatomic, retain) IBOutlet UIProgressView * shutterProgress;
@property (nonatomic, retain) IBOutlet UIImageView * imageView;




@end
