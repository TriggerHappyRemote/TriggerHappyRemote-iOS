//
//  AppDelegate.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

@class IntervalData;
@class IIntervalometer;
@class IntervalometerViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    IntervalData *intervalData;
    IIntervalometer *intervalometerModel;    
    IntervalometerViewController *intervalVC;
}

- (IntervalData*) getIntervalData;

- (IIntervalometer*) getIntervalometerModel;

-(void) setIntervalVC: (IntervalometerViewController *) vc;

- (IntervalometerViewController *) getIntervalVC;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) IntervalData *intervalData;
@property (strong, nonatomic) IIntervalometer *intervalometerModel;


@end
