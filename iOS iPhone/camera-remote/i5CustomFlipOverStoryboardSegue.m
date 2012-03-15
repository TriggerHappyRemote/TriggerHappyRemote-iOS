
#import "i5CustomFlipOverStoryboardSegue.h"
@implementation i5CustomFlipOverStoryboardSegue
@synthesize appDelegate=_appDelegate;
-(void) perform{
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    UIViewController *srcViewController = (UIViewController *) self.sourceViewController;
    UIViewController *destViewController = (UIViewController *) self.destinationViewController;
    [UIView commitAnimations];
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:self.appDelegate.window.rootViewController.view.superview cache:YES];
    [srcViewController.view removeFromSuperview];
    [UIView commitAnimations];
    [self.appDelegate.window addSubview:destViewController.view];
    self.appDelegate.window.rootViewController=destViewController;
}
@end