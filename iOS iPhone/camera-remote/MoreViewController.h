//
//  MoreViewController.h
//  camera-remote
//
//  Created by Kevin Harrington on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
}



@property (nonatomic, strong) UITableView * tableView;
@end
