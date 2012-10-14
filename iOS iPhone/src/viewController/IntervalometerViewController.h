//
//  IntervalometerViewController.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IntervalData.h"
#import "IDataAccessViewController.h"

@interface IntervalometerViewController : IDataAccessViewController
                                                            
-(IBAction) startButtonPressed;

- (void) setButtonTitles;
- (IBAction)startButtonPressedSingleShot:(id)sender;

@property (nonatomic, retain) IBOutlet UINavigationItem *navigation;

@property (nonatomic, retain) IBOutlet UIButton * intervalSetButton;
@property (nonatomic, retain) IBOutlet UIButton * durationSetButton;

// only one of these will show at a time, based on the 'settings' index
//  settings is declared below
@property (nonatomic, retain) IBOutlet UIButton * hdrSetButton;
@property (nonatomic, retain) IBOutlet UIButton * brampingSetButton;
@property (nonatomic, retain) IBOutlet UIButton * shutterSetButton;

@property (nonatomic, retain) IBOutlet UILabel * shutterLabel;
@property (nonatomic, retain) IBOutlet UILabel * intervalLabel;
@property (nonatomic, retain) IBOutlet UILabel * durationLabel;

/**
 * Settings segemts - Standard | HDR | Bramping
 * 
 * Note: In this version HDR and Bramping cannot be combined
 */
@property (nonatomic, retain) IBOutlet UISegmentedControl * settings;

/**
 *
 * When UISegmentControl settings above changes, this updates the view
 */
-(IBAction) segmentSettingsChanged;



@end
