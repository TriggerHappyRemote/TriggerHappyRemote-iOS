//
//  TimeBetweenShotsViewController.h
//  Trigger Happy
//
//  Created by Kevin Harrington on 9/20/12.
//
//

#import <UIKit/UIKit.h>

@interface TimeBetweenShotsViewController : UIViewController {
    
    __weak IBOutlet UILabel *time;
    __weak IBOutlet UISlider *timeSlider;
}

@end
