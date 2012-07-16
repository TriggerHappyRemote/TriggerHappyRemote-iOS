//
//  HDRViewController.h
//  camera-remote
//
//  Created by Kevin Harrington on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@class InfoViewController;

@interface HDRShotsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    UIPickerView       *picker;
    InfoViewController *infoViewController;

}

@property (strong, nonatomic) IBOutlet UIPickerView *picker;

-(IBAction)textFieldReturn:(id)sender;


@end
