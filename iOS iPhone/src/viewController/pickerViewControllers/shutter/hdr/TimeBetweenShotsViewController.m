//
//  TimeBetweenShotsViewController.m
//  Trigger Happy
//
//  Created by Kevin Harrington on 9/20/12.
//
//

#import "TimeBetweenShotsViewController.h"
#include "IntervalData.h"

@interface TimeBetweenShotsViewController ()

@end

@implementation TimeBetweenShotsViewController

-(void) viewWillAppear:(BOOL)animated {
    //timeSlider.value = [IntervalData getInstance].shutter  ;
    time.text = @"0.33 Seconds";
}

- (IBAction)timeValueDidChange:(id)sender {
    
    // .1 and 2 seconds   1.9 seconds
    time.text = [[NSString alloc] initWithFormat:@"%.02f Seconds", timeSlider.value * 1.9 + .1];
}

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    time = nil;
    timeSlider = nil;
    [super viewDidUnload];
}



@end
