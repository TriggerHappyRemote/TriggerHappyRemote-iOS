//
//  InfoViewController.m
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
//
//  Created by Kevin Harrington on 1/9/12.
//  
//

#import "InfoViewController.h"

@interface InfoViewController() 
-(id) initWithLocationPhone:(float) x and:(float)y;
-(id) initWithLocationPad:(float) x and:(float)y;

@end

@implementation InfoViewController

@synthesize type = _type, text, hidden = _hidden, position = _position;

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

- (void) setPosition:(CGPoint)position {
    _position = position;
    self.view.frame = CGRectMake(_position.x, _position.y, self.view.frame.size.width, self.view.frame.size.height);
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
