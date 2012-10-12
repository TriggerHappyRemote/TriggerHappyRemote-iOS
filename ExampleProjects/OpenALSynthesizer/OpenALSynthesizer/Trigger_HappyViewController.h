//
//  Trigger_HappyViewController.h
//  OpenALSynthesizer
//
//  Created by Kevin Harrington on 10/12/12.
//  Copyright (c) 2012 Kevin Harrington. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OpenALSynthesizer;

@interface Trigger_HappyViewController : UIViewController {
    OpenALSynthesizer * audioMan;
    BOOL playing;
}

@end
