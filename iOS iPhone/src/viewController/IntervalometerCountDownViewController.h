//
//  IntervalometerCountDownViewController.h
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
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

-(void) notifyOfInterrupt:(NSString *) currentTime;

-(void) notifyOfInterruptToUpdateIntervalProgress:(float) percentage;

-(void) notifyOfInterruptToUpdatShutterProgress:(float) percentage;

-(void) notifyOfDurationEnd;

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
