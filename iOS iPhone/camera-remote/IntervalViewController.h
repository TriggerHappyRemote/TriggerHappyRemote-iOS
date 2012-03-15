//
//  IntervalViewController.h
//  camera-remote
//
//  Created by Kevin Harrington on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntervalViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView       *picker;
    NSMutableArray     *secsValues;
    NSMutableArray     *hoursValues;
    UILabel            *secsLabel;
    UILabel            *minsLabel;
    UILabel            *hoursLabel;
}

@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UILabel *secsLabel;
@property (strong, nonatomic) IBOutlet UILabel *minsLabel;
@property (strong, nonatomic) IBOutlet UILabel *hoursLabel;
@property (strong, nonatomic) NSMutableArray *secsValues;
@property (strong, nonatomic) NSMutableArray *hoursValues;

-(IBAction)textFieldReturn:(id)sender;
@end  