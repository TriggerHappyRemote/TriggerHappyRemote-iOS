//
//  HDREVViewController.h
//  camera-remote
//
//  Created by Kevin Harrington on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDREVViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *picker;
//@property (strong, nonatomic) IBOutlet NSMutableArray *exposureValues;


-(IBAction)textFieldReturn:(id)sender;





@end
