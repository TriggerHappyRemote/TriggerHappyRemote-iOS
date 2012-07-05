//
//  InfoViewController.m
//  Trigger Happy
//
//  Created by Kevin Harrington on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController() 
-(id) initWithLocation:(float) x and:(float)y;
@end

@implementation InfoViewController

@synthesize type = _type, text, hidden = _hidden;

-(id) initWithLocation:(float) x and:(float)y {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(x,y,320,83)];
    self.view.backgroundColor = [UIColor clearColor];
    background = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,0.0,320,83)];
    self.type = InfoViewControllerWarning;
    [self.view addSubview:background];
    info = [[UILabel alloc] initWithFrame:CGRectMake(84.0,9.0,205,65)];
    info.backgroundColor = [UIColor clearColor];
    info.textColor = [UIColor whiteColor];
    info.numberOfLines = 3;
    [self.view addSubview:info];
    return self;
}

+(InfoViewController *) withLocation:(float) x and:(float)y {
    return [[InfoViewController alloc] initWithLocation:x and:y];
}

-(void) setType:(InfoViewControllerType)type {
    _type = type;
    switch (type) {
        case InfoViewControllerInfo:
            background.image = [UIImage imageNamed:@"info.png"];
            break;
        case InfoViewControllerWarning:
            background.image = [UIImage imageNamed:@"warning.png"];
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

@end
