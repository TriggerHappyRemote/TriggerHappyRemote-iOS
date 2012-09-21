//
//  main.m
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "AppDelegate.h"
#include "Constants.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
#if TEST == 1
        NSLog(@"Warning: This is in test mode. DO NOT SHIP IN THIS STATE!");
#elif PRODUCT == 1
        NSLog(@"Production build");
#endif
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}