
//
//  ResultsViewController.m
//  ToneMapping
//
//  Created by Kevin Harrington on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultsViewController.h"
#import "AppDelegate.h"

@interface ResultsViewController ()
@end

@implementation ResultsViewController
@synthesize resultImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    resultImage.image = [appDelegate.hdrToneMapper proccessImage:128];
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setResultImage:nil];
    gammaSlider = nil;
    [super viewDidUnload];
}

- (IBAction)gammaSliderValueDidChange:(id)sender {
    //NSLog(@"val: %f", gammaSlider.value);
    //resultImage.image = [appDelegate.hdrToneMapper proccessImage:255.0*gammaSlider.value];

}
- (IBAction)gammaSliderTouchUp:(id)sender {
    NSLog(@"val: %f", gammaSlider.value);
    resultImage.image = [appDelegate.hdrToneMapper proccessImage:255.0*gammaSlider.value];

}


@end
