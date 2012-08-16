//
//  helpModalViewContollerViewController.m
//  Trigger Happy
//
//  Created by Kevin Harrington on 8/15/12.
//
//

#import "helpModalViewContollerViewController.h"
#import "InfoViewController.h"

@interface helpModalViewContollerViewController ()

@end

@implementation helpModalViewContollerViewController
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    InfoViewController *infoViewController1 = [InfoViewController withLocationForPhone:0 and:0];
    InfoViewController *infoViewController2 = [InfoViewController withLocationForPhone:0 and:50];
    InfoViewController *infoViewController3 = [InfoViewController withLocationForPhone:0 and:100];
    InfoViewController *infoViewController4 = [InfoViewController withLocationForPhone:0 and:200];
    InfoViewController *infoViewController5 = [InfoViewController withLocationForPhone:0 and:400];

    [scrollView addSubview:infoViewController1.view];
    [scrollView addSubview:infoViewController2.view];
    [scrollView addSubview:infoViewController3.view];
    [scrollView addSubview:infoViewController5.view];
    [scrollView addSubview:infoViewController4.view];
    
    // set the content size so it can be scrollable
	[scrollView setContentSize:CGSizeMake([scrollView bounds].size.width, 500)];



}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)backButtonPressed {
    //[self.view removeFromSuperview];
    //[self removeFromParentViewController];
    [self dismissModalViewControllerAnimated:YES];
    
}

@end
