//
//  HDRViewController.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

@class InfoViewController;

@interface HDRShotsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    UIPickerView       *picker;
    InfoViewController *infoViewController;
}

@property (strong, nonatomic) IBOutlet UIPickerView *picker;

-(IBAction)textFieldReturn:(id)sender;

@end
