//
//  DurationViewController.h
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DurationViewController : UIViewController {
    UIDatePicker *durationPicker;
    UISegmentedControl *duration;
}

-(IBAction) toggleSegmentControl;

@property (nonatomic, retain) IBOutlet UIDatePicker *durationPicker;
@property (nonatomic, retain) IBOutlet UISegmentedControl *duration;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UILabel *warningBackground;

@end
