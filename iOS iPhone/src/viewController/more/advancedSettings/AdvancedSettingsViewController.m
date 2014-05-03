//
//  AdvancedSettingsViewController.m
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
//  Created by Kevin Harrington on 10/12/12.
//
//

#import "AdvancedSettingsViewController.h"
#import "IntervalData.h"
#import "AudioOutputCameraController.h"
#import "LEGACYAudioOutputCameraController.h"
#import "ICameraController.h"
#import "Constants.h"
#import "HardwareManager.h"

#define CHECK_MARK_Y_NEW_PHONE 63
#define CHECK_MARK_Y_OLD_PHONE 83

#define CHECK_MARK_Y_NEW_PAD 115
#define CHECK_MARK_Y_OLD_PAD 156

@implementation AdvancedSettingsViewController
- (IBAction)hardwareDetectionPressed:(id)sender {
    if(normalHardwareDetection == (UIButton *)sender) {
        if(IDIOM == IPAD)
            [checkMarkHardware setFrame:CGRectMake(checkMark.frame.origin.x, 249, checkMark.frame.size.width, checkMark.frame.size.height)];
        else
            [checkMarkHardware setFrame:CGRectMake(checkMark.frame.origin.x, 192, checkMark.frame.size.width, checkMark.frame.size.height)];
        [HardwareManager getInstance].hardwareDetection = YES;
        
    } else {
        if(IDIOM == IPAD)
            [checkMarkHardware setFrame:CGRectMake(checkMark.frame.origin.x, 290, checkMark.frame.size.width, checkMark.frame.size.height)];
        else
            [checkMarkHardware setFrame:CGRectMake(checkMark.frame.origin.x, 233, checkMark.frame.size.width, checkMark.frame.size.height)];
        
        [HardwareManager getInstance].hardwareDetection = NO;
    }
    
}

- (IBAction)soundSelectorPressed:(id)sender {
    if(newSoundButton == (UIButton *)sender) {
        if(IDIOM == IPAD)
            [checkMark setFrame:CGRectMake(checkMark.frame.origin.x, CHECK_MARK_Y_NEW_PAD, checkMark.frame.size.width, checkMark.frame.size.height)];
        else
            [checkMark setFrame:CGRectMake(checkMark.frame.origin.x, CHECK_MARK_Y_NEW_PHONE, checkMark.frame.size.width, checkMark.frame.size.height)];

        [[HardwareManager getInstance] changeCameraControllerTo:CAMERA_CONTROLLER_NEW];

    } else {
        if(IDIOM == IPAD)
            [checkMark setFrame:CGRectMake(checkMark.frame.origin.x, CHECK_MARK_Y_OLD_PAD, checkMark.frame.size.width, checkMark.frame.size.height)];
        else
            [checkMark setFrame:CGRectMake(checkMark.frame.origin.x, CHECK_MARK_Y_OLD_PHONE, checkMark.frame.size.width, checkMark.frame.size.height)];

        [[HardwareManager getInstance] changeCameraControllerTo:CAMERA_CONTROLLER_OLD];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    if([HardwareManager getInstance].cameraControllerType == CAMERA_CONTROLLER_NEW) {
        if(IDIOM == IPAD)
            [checkMark setFrame:CGRectMake(checkMark.frame.origin.x, CHECK_MARK_Y_NEW_PAD, checkMark.frame.size.width, checkMark.frame.size.height)];
        else
            [checkMark setFrame:CGRectMake(checkMark.frame.origin.x, CHECK_MARK_Y_NEW_PHONE, checkMark.frame.size.width, checkMark.frame.size.height)];
    } else {
        if(IDIOM == IPAD)
            [checkMark setFrame:CGRectMake(checkMark.frame.origin.x, CHECK_MARK_Y_OLD_PAD, checkMark.frame.size.width, checkMark.frame.size.height)];
        else
            [checkMark setFrame:CGRectMake(checkMark.frame.origin.x, CHECK_MARK_Y_OLD_PHONE, checkMark.frame.size.width, checkMark.frame.size.height)];
    }
    
    if([HardwareManager getInstance].hardwareDetection) {
        if(IDIOM == IPAD)
            [checkMarkHardware setFrame:CGRectMake(checkMark.frame.origin.x, 249, checkMark.frame.size.width, checkMark.frame.size.height)];
        else
            [checkMarkHardware setFrame:CGRectMake(checkMark.frame.origin.x, 192, checkMark.frame.size.width, checkMark.frame.size.height)];        
    } else {
        if(IDIOM == IPAD)
            [checkMarkHardware setFrame:CGRectMake(checkMark.frame.origin.x, 290, checkMark.frame.size.width, checkMark.frame.size.height)];
        else
            [checkMarkHardware setFrame:CGRectMake(checkMark.frame.origin.x, 233, checkMark.frame.size.width, checkMark.frame.size.height)];
    }
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    newSoundLabel = nil;
    oldSoundLabel = nil;
    checkMark = nil;
    newSoundButton = nil;
    oldSoundButton = nil;
    normalHardwareDetection = nil;
    noHardwareDetection = nil;
    checkMarkHardware = nil;
    [super viewDidUnload];
}
@end
