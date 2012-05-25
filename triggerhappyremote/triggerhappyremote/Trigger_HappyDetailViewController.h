//
//  Trigger_HappyDetailViewController.h
//  triggerhappyremote
//
//  Created by Kevin Harrington on 5/24/12.
//  Copyright (c) 2012 SmugMug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Trigger_HappyDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
