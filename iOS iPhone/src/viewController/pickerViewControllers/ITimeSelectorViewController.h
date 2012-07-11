//
//  ITimeSelectorViewController.h
//  Trigger Happy, V1.0
//
//  Created by Kevin Harrington on 4/23/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//
//  Supercass for all ViewControllers using a 3 column UIPickerView 
//  


#import "Constants.h"

@class InfoViewController;
@class IntervalData;
@class Time;

@interface ITimeSelectorViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    @protected 
    InfoViewController * infoViewController;
}

@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UILabel *label_2;
@property (strong, nonatomic) IBOutlet UILabel *label_1;
@property (strong, nonatomic) IBOutlet UILabel *label_0;

@property (strong, nonatomic) NSMutableArray *subSecondsValues;
@property (strong, nonatomic) NSMutableArray *subSecondsValuesNumbers;
@property (strong, nonatomic) NSMutableArray *secondsValues;
@property (strong, nonatomic) NSMutableArray *minutesValues;
@property (strong, nonatomic) NSMutableArray *hoursValues;

@property (nonatomic, strong) IBOutlet UISegmentedControl * segment;

//@property (strong, nonatomic) IBOutlet UILabel *instructionLabel;

//@property (retain, nonatomic) IBOutlet UIImageView *warningBackround;


// model ref
@property (strong, nonatomic) IntervalData * intervalData;

@property (retain, nonatomic) IBOutlet UISegmentedControl *secondSubSecondSegment;

-(IBAction)textFieldReturn:(id)sender;

// Delegates that will be registered to a model source in the
//  class inheriting this superclass
-(void) changeHour: (int) hour;
-(void) changeMinute: (int) minute;
-(void) changeSecond: (int) second;
-(void) changeMillisecond: (int) millisecond;


// delegates to set and get picker state
-(Time *) time;


@end  