//
//  helpModalViewContollerViewController.m
//  Copyright (c) 2014 Kevin Harrington
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Created by Kevin Harrington on 8/15/12.
//
//

#import "helpModalViewContollerViewController.h"
#import "InfoViewController.h"

#import "SingleShotScrollingHelpViewController.h"

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
    
    
    SingleShotScrollingHelpViewController *help = [[SingleShotScrollingHelpViewController alloc] initWithNibName:@"SingleShotViewControllerInstructions_Phone" bundle:nil];
    
    
    //help.view.backgroundColor = [UIColor blackColor];


    [scrollView addSubview:help.view];

    
    // set the content size so it can be scrollable
	[scrollView setContentSize:CGSizeMake([scrollView bounds].size.width, 700)];



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
