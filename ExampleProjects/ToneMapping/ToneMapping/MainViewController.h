//
//  DetailViewController.h
//  ToneMapping
//
//  Created by Kevin Harrington on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController {
    // need to be strong, passed to hdrToneMapper
    IBOutlet UIImageView *preview1;
    IBOutlet UIImageView *preview2;
    IBOutlet UIImageView *preview3;
    
    __weak IBOutlet UIButton *image1Selector;
    __weak IBOutlet UIButton *image2Selector;
    __weak IBOutlet UIButton *image3Selector;
}

@end
