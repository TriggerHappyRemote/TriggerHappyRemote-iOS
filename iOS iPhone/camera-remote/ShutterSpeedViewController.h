//
//  IntervalViewController.h
//  camera-remote
//
//  Created by Kevin Harrington on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShutterSpeedViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView       *picker;
    NSMutableArray     *secsValues;
    NSMutableArray     *hoursValues;
    UILabel            *secsLabel;
    UILabel            *minsLabel;
    UILabel            *hoursLabel;
    UILabel            *instructionLabel;
    UISegmentedControl *autoBulbSegment;
}

-(IBAction) toggleSegmentControl;

@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UILabel *secsLabel;
@property (strong, nonatomic) IBOutlet UILabel *minsLabel;
@property (strong, nonatomic) IBOutlet UILabel *hoursLabel;
@property (strong, nonatomic) NSMutableArray *secsValues;
@property (strong, nonatomic) NSMutableArray *hoursValues;
@property (strong, nonatomic) IBOutlet UILabel *instructionLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *autoBulbSegment;


-(IBAction)textFieldReturn:(id)sender;
@end  