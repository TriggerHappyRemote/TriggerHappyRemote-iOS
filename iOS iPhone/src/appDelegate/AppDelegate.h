//
//  AppDelegate.h
//  camera-remote
//
//  Created by Kevin Harrington on 12/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntervalData.h"
#import "IIntervalometer.h"
#import "IntervalometerViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    IntervalData *intervalData;
    IIntervalometer *intervalometerModel;    
    IntervalometerViewController * intervalVC;
}

- (IntervalData*) getIntervalData;

- (IIntervalometer*) getIntervalometerModel;

-(void) setIntervalVC: (IntervalometerViewController *) vc;

- (IntervalometerViewController *) getIntervalVC;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) IntervalData *intervalData;
@property (strong, nonatomic) IIntervalometer *intervalometerModel;


@end