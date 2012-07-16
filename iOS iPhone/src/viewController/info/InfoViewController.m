//
//  InfoViewController.m
//  Trigger Happy
//
//  Created by Kevin Harrington on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController() 
-(id) initWithLocationPhone:(float) x and:(float)y;
-(id) initWithLocationPad:(float) x and:(float)y;

@end

@implementation InfoViewController

@synthesize type = _type, text, hidden = _hidden;

-(id) initWithLocationPhone:(float) x and:(float)y {
    warningImage =  [UIImage imageNamed:@"warning.png"];
    infoImage =  [UIImage imageNamed:@"info.png"];
    self.view = [[UIView alloc] initWithFrame:CGRectMake(x,y,320,83)];
    self.view.backgroundColor = [UIColor clearColor];
    background = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,0.0,320,83)];
    self.type = InfoViewControllerWarning;
    [self.view addSubview:background];
    info = [[UILabel alloc] initWithFrame:CGRectMake(84.0,9.0,205,65)];
    info.backgroundColor = [UIColor clearColor];
    info.textColor = [UIColor whiteColor];
    info.numberOfLines = 3;
    info.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:info];
    return self;
}

-(id) initWithLocationPad:(float) x and:(float)y {
    warningImage =  [UIImage imageNamed:@"warning_PAD.png"];
    infoImage =  [UIImage imageNamed:@"info_PAD.png"];
    self.view = [[UIView alloc] initWithFrame:CGRectMake(x,y,604,148)];
    self.view.backgroundColor = [UIColor clearColor];
    background = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,0.0,604,148)];
    self.type = InfoViewControllerWarning;
    [self.view addSubview:background];
    info = [[UILabel alloc] initWithFrame:CGRectMake(118,21,445,117)];
    info.backgroundColor = [UIColor clearColor];
    info.textColor = [UIColor whiteColor];
    info.numberOfLines = 3;
    info.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:info];
    return self;
}



+(InfoViewController *) withLocationForPhone:(float) x and:(float)y {
    return [[InfoViewController alloc] initWithLocationPhone:x and:y];
}

+(InfoViewController *) withLocationForPad:(float) x and:(float)y {
    return [[InfoViewController alloc] initWithLocationPad:x and:y];
}


-(void) setType:(InfoViewControllerType)type {
    _type = type;
    switch (type) {
        case InfoViewControllerInfo:
            background.image = infoImage;
            break;
        case InfoViewControllerWarning:
            background.image = warningImage;
            break;
    }
}

-(void) setText:(NSString *)__text {
    info.text = __text;
}

-(NSString *)text {
    return info.text;
}

-(void) setHidden:(bool)hidden {
    self.view.hidden = hidden;
} 

-(void) viewDidUnload {
    background = nil;
    info = nil;
    self.text = nil;
    warningImage = nil;
    infoImage = nil;
}

@end
