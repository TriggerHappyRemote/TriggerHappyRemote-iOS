//
//  IShutterSelectorViewController.m
//  Trigger-Happy
//
//  Created by Kevin Harrington on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IShutterSelectorViewController.h"

@implementation IShutterSelectorViewController

-(void) upperBoundsCheck:(NSInteger)row
             inComponent:(NSInteger)component {
    Time * max = [[self.intervalData interval] time];
    if([[self time] totalTimeInSeconds] >= [max totalTimeInSeconds]) {
        
        [self.picker selectRow:[max hours] inComponent:0 animated:false];
        [self.picker selectRow:[max minutes] inComponent:1 animated:false];
        [self.picker selectRow:[max seconds]-1 inComponent:2 animated:false];
        
        [self changeHour:[max hours]];
        [self changeMinute:[max minutes]];
        [self changeSecond:[max seconds]-1];
    }
    
}

@end
