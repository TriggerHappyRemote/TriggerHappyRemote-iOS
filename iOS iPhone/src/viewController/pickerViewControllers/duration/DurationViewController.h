//
//  DurationViewController.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
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
