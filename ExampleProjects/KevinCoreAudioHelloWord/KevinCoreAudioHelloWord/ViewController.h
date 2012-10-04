//
//  ViewController.h
//  KevinCoreAudioHelloWord
//
//  Created by Kevin Harrington on 10/3/12.
//  Copyright (c) 2012 Kevin Harrington. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioController.h"

@interface ViewController : UIViewController {
	IBOutlet AudioController *audioController;
    __weak IBOutlet UISlider *audioFreqSlider;
    __weak IBOutlet UILabel *audioFreqLabel;
    __weak IBOutlet UIButton *toggleAudioButton;
    @private
    bool audioOn;
}

@property (readonly, nonatomic) AudioController *audioController;
@end