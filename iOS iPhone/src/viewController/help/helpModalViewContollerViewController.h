//
//  helpModalViewContollerViewController.h
//  Trigger Happy
//
//  Created by Kevin Harrington on 8/15/12.
//
//

#import <UIKit/UIKit.h>

@interface helpModalViewContollerViewController : UIViewController {
    IBOutlet UIScrollView *scrollView;	// holds five small images to scroll horizontally
}

@property (nonatomic, retain) IBOutlet UIView *scrollView;

-(IBAction)backButtonPressed;

@end
