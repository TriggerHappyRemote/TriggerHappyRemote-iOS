//
//  AdvancedSettingsViewController.m
//  Trigger Happy
//
//  Created by Kevin Harrington on 10/12/12.
//
//

#import "AdvancedSettingsViewController.h"
#import "IntervalData.h"
#import "AudioOutputCameraController.h"
#import "LEGACYAudioOutputCameraController.h"
#import "ICameraController.h"

#define CHECK_MARK_Y_NEW_PHONE 63
#define CHECK_MARK_Y_OLD_PHONE 101

@implementation AdvancedSettingsViewController

- (IBAction)soundSelectorPressed:(id)sender {
    if(newSoundButton == (UIButton *)sender) {
        NSLog(@"new sound button");
        [checkMark setFrame:CGRectMake(checkMark.frame.origin.x, CHECK_MARK_Y_NEW_PHONE, checkMark.frame.size.width, checkMark.frame.size.height)];
        [[IntervalData getInstance] changeCameraControllerTo:CAMERA_CONTROLLER_NEW];

    } else {
        [checkMark setFrame:CGRectMake(checkMark.frame.origin.x, CHECK_MARK_Y_OLD_PHONE, checkMark.frame.size.width, checkMark.frame.size.height)];
        NSLog(@"old sound button");
        [[IntervalData getInstance] changeCameraControllerTo:CAMERA_CONTROLLER_OLD];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    if([IntervalData getInstance].cameraControllerType == CAMERA_CONTROLLER_NEW) {
        [checkMark setFrame:CGRectMake(checkMark.frame.origin.x, CHECK_MARK_Y_NEW_PHONE, checkMark.frame.size.width, checkMark.frame.size.height)];
    } else {
        [checkMark setFrame:CGRectMake(checkMark.frame.origin.x, CHECK_MARK_Y_OLD_PHONE, checkMark.frame.size.width, checkMark.frame.size.height)];
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
    [super viewDidUnload];
}
@end
