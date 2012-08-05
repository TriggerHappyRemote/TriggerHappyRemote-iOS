//
//  HDREVViewController.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

@class InfoViewController;

@interface HDREVViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet InfoViewController * infoViewController;
}


@property (strong, nonatomic) IBOutlet UIPickerView *picker;


-(IBAction)textFieldReturn:(id)sender;




@end
