//
//  DetailViewController.m
//  ToneMapping
//
//  Created by Kevin Harrington on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@interface MainViewController (UIImagePickerControllerDelegate) <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@end

@interface MainViewController ()
- (void)imageSelectorButtonPressed:(int)selectorIndex;
@property (nonatomic) NSInteger currentSelectorIndex;
@end

@implementation MainViewController

@synthesize currentSelectorIndex;

-(void) viewWillAppear:(BOOL)animated {
}

- (IBAction)image1SelectorPressed:(id)sender {
    self.currentSelectorIndex = 1;
    [self imageSelectorButtonPressed:1];
}
- (IBAction)image2SelectorPressed:(id)sender {
    self.currentSelectorIndex = 2;
    [self imageSelectorButtonPressed:2];
}
- (IBAction)image3SelectorPressed:(id)sender {
    self.currentSelectorIndex = 3;
    [self imageSelectorButtonPressed:3];
}


- (void)imageSelectorButtonPressed:(int)selectorIndex {
    
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;			
	picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
	picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    
	
    [self presentModalViewController:picker animated:YES];
}

- (void)viewDidUnload {
    preview1 = nil;
    preview2 = nil;
    preview3 = nil;
    image1Selector = nil;
    image2Selector = nil;
    image3Selector = nil;
    [super viewDidUnload];

}
- (IBAction)proccessButtonPressed:(id)sender {
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.hdrToneMapper = [HDRToneMapper operationWithImages:preview1.image second:preview2.image third:preview3.image];    
}
@end

/**-------------------------------------------------------------------------**/
@implementation MainViewController (UIImagePickerControllerDelegate)

/*
 An image was picked, store it in memory
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //UIImage *pickerImage = [info objectForKey:@"image"];
    // TOOD - load images
    
    
    [self dismissModalViewControllerAnimated:YES];


}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}

@end