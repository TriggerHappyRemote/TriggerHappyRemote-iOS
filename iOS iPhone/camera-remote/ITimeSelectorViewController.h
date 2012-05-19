//
//  ITimeSelectorViewController.h
//  Trigger Happy, V1.0
//
//  Created by Kevin Harrington on 4/23/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//
//  Supercass for all ViewControllers using a 3 column UIPickerView 
//  

#import <UIKit/UIKit.h>
#import "IntervalData.h"
#import "Time.h"

@interface ITimeSelectorViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
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

@property (strong, nonatomic) IBOutlet UILabel *instructionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *warningBackround;


// model ref
@property (strong, nonatomic) IntervalData * intervalData;

@property (weak, nonatomic) IBOutlet UISegmentedControl *secondSubSecondSegment;

-(IBAction)textFieldReturn:(id)sender;

// Methods that will be overridden by the subclasses
//
// Due to the dynamic nature of the compiler, these can't be "protected"
// like in other c-family lanuages
//


-(void) loadHoursArray;

-(void) loadMinutesArray;

-(void) loadSecondsArray;

-(void) loadSubSecondsArray;


// Delegates that will be registered to a model source in the
//  class inheriting this superclass
-(void) changeHour: (int) hour;

-(void) changeMinute: (int) minute;

-(void) changeSecond: (int) second;

-(void) changeMillisecond: (int) millisecond;

// Delegate to load time from a model
-(Time *) time;

-(IBAction) segmentDidChange;

-(void) setPickerVisibility;

-(void) registerSegmentChangeToModel;

-(int) getSegmentIndex;

-(IBAction)secondSubSecondSegmentChange;

// delegates to set and get picker state
-(void) setPickerMode: (PickerMode) state;

-(PickerMode) getPickerMode;

-(void) upperBoundsCheck:(NSInteger)row
             inComponent:(NSInteger)component;
-(void) lowerBoundsCheck:(NSInteger)row
inComponent:(NSInteger)component;


@end  