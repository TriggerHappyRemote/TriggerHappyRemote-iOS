//
//  MainTabBarController.h
//  camera-remote
//
//  Created by Kevin Harrington on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainTabBarController : UITabBarController {
    UITabBarItem * single;
    UITabBarItem * bulb;
    UITabBarItem * timer;
    UITabBarItem * interval;
    UITabBarItem * more;
}

@property (nonatomic, retain) IBOutlet UITabBarItem *single;
@property (nonatomic, retain) IBOutlet UITabBarItem *bulb;
@property (nonatomic, retain) IBOutlet UITabBarItem *timer;
@property (nonatomic, retain) IBOutlet UITabBarItem *interval;
@property (nonatomic, retain) IBOutlet UITabBarItem *more;





@end
