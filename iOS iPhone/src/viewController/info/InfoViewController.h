//
//  InfoViewController.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//


typedef enum {
    InfoViewControllerWarning,
    InfoViewControllerInfo
} InfoViewControllerType;

@interface InfoViewController : UIViewController {
    IBOutlet UIImageView * background;
    IBOutlet UILabel * info;
    
    UIImage * warningImage;
    UIImage * infoImage;
}

+(InfoViewController *) withLocationForPhone:(float) x and:(float)y;

+(InfoViewController *) withLocationForPad:(float) x and:(float)y;


@property (nonatomic) InfoViewControllerType type;
@property (retain, nonatomic) NSString * text;
@property (nonatomic) bool hidden;

@end
