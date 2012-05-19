//
//  DurationViewController.h
//  camera-remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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
