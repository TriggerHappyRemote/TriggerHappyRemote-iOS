//
//  AdvancedSettingsViewController.h
//  Trigger Happy
//
//  Created by Kevin Harrington on 10/12/12.
//
//

#import <UIKit/UIKit.h>

@interface AdvancedSettingsViewController : UIViewController {
    __weak IBOutlet UILabel *newSoundLabel;
    __weak IBOutlet UILabel *oldSoundLabel;
    __weak IBOutlet UIImageView *checkMark;
    __weak IBOutlet UIButton *newSoundButton;
    __weak IBOutlet UIButton *oldSoundButton;
}

@end
