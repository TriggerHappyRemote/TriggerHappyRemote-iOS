//
//  ITimeSelectorViewController.h
//  Copyright (c) 2014 Kevin Harrington
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//
//  Created by Kevin Harrington on 1/9/12.
//  
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

//@property (strong, nonatomic) NSMutableArray *subSecondsValues;
@property (strong, nonatomic) NSMutableArray *subSecondsValuesNumbers;
@property (strong, nonatomic) NSMutableArray *secondsValues;
@property (strong, nonatomic) NSMutableArray *minutesValues;
@property (strong, nonatomic) NSMutableArray *hoursValues;

@property (nonatomic, strong) IBOutlet UISegmentedControl * segment;

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