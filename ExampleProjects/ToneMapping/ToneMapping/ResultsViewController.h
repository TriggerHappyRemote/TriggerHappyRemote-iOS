//
//  ResultsViewController.h
//  ToneMapping
//
//  Created by Kevin Harrington on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface ResultsViewController : UIViewController {
    __weak IBOutlet UISlider *gammaSlider;
    AppDelegate * appDelegate;
}

@property (weak, nonatomic) IBOutlet UIImageView *resultImage;

@end
