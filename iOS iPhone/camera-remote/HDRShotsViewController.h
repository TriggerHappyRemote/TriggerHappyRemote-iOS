//
//  HDRViewController.h
//  camera-remote
//
//  Created by Kevin Harrington on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDRShotsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView       *picker;

}

@property (strong, nonatomic) IBOutlet UIPickerView *picker;


-(IBAction)textFieldReturn:(id)sender;



@end
