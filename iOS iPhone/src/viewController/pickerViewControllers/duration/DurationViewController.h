//
//  DurationViewController.h
//  Trigger Happy V1.0 Lite
//
//  Created by Kevin Harrington on 10/10/11.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

@class InfoViewController;

@interface DurationViewController : UIViewController {
    @protected
    InfoViewController * infoViewController;
}

-(IBAction) toggleSegmentControl;

@property (nonatomic, retain) IBOutlet UIDatePicker *durationPicker;
@property (nonatomic, retain) IBOutlet UISegmentedControl *duration;

@end
