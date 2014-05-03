//
//  IntervalometerCountDownViewController.h
//  Copyright (c) 2014 Kevin Harrington
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  Created by Kevin Harrington on 1/9/12.
//  
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
