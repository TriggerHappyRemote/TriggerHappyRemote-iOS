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
@property (strong, nonatomic) IBOutlet UILabel *secsLabel;
@property (strong, nonatomic) IBOutlet UILabel *minsLabel;
@property (strong, nonatomic) IBOutlet UILabel *hoursLabel;

@property (strong, nonatomic) NSMutableArray *secondsValues;
@property (strong, nonatomic) NSMutableArray *minutesValues;
@property (strong, nonatomic) NSMutableArray *hoursValues;

@property (nonatomic, strong) IBOutlet UISegmentedControl * segment;

@property (strong, nonatomic) IBOutlet UILabel *instructionLabel;

// model ref
@property (strong, nonatomic) IntervalData * intervalData;

@property (nonatomic) bool instructionLabelVisible;


-(IBAction)textFieldReturn:(id)sender;

// TODO: make private
-(void) loadDefaultTime;

// Methods that will be overridden by the subclasses
//
// Due to the dynamic nature of the compiler, these can't be "protected"
// like in other c-family lanuages
//

-(void) initializeInstructionLabel;

-(void) loadHoursArray;

-(void) loadMinutesArray;

-(void) loadSecondsArray;

// Delegates that will be registered to a model source in the
//  class inheriting this superclass
-(void) changeHour: (int) hour;

-(void) changeMinute: (int) minute;

-(void) changeSecond: (int) second;

// Delegate to load time from a model
-(Time *) time;

-(IBAction) segmentDidChange;

-(void) setPickerVisibility;

-(void) registerSegmentChangeToModel;



@end  