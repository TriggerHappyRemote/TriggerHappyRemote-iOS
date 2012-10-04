//
//  ViewController.m
//  KevinCoreAudioHelloWord
//
//  Created by Kevin Harrington on 10/3/12.
//  Copyright (c) 2012 Kevin Harrington. All rights reserved.
//

#import "ViewController.h"

#define MAX_HZ 30000
#define MIN_HZ 10

@interface ViewController ()


@end

@implementation ViewController

@synthesize audioController;

- (IBAction)audioFreqDidChange:(id)sender {
    audioController.hertz = (audioFreqSlider.value * (MAX_HZ-MIN_HZ))+MIN_HZ;
    audioFreqLabel.text = [NSString stringWithFormat:@"audio freq: %.02f hz", audioController.hertz];
}

- (IBAction)audioToggleTouchUp:(id)sender {
    audioOn = !audioOn;
    if(audioOn) {
        [audioController startAUGraph];
    } else {
        [audioController stopAUGraph];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[audioController initializeAUGraph];
	[audioController startAUGraph];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    [audioController stopAUGraph];
    audioController = nil;
}

@end
