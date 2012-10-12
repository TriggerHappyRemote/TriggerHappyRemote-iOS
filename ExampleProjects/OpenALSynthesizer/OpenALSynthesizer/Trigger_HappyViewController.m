//
//  Trigger_HappyViewController.m
//  OpenALSynthesizer
//
//  Created by Kevin Harrington on 10/12/12.
//  Copyright (c) 2012 Kevin Harrington. All rights reserved.
//

#import "Trigger_HappyViewController.h"
#import "OpenALSynthesizer.h"

@interface Trigger_HappyViewController ()

@end

@implementation Trigger_HappyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    audioMan = [[OpenALSynthesizer alloc] init];
    [audioMan loadFile:@"1second" doesLoop:true];
    playing = false;

    
    
    
    
}
- (IBAction)playButtonPressed:(id)sender {
    if(playing)
        [audioMan pauseSound:@"1second"];
    else
        [audioMan playSound:@"1second" doesLoop:YES];
    
    playing = !playing;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
