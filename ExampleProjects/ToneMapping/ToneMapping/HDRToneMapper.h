//
//  HDRToneMapper.h
//  ToneMapping
//
//  Created by Kevin Harrington on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDRToneMapper : NSObject

+ (HDRToneMapper *)operationWithImages:(UIImage *)img1 second:(UIImage *)img2 third:(UIImage *)img3;
- (UIImage *) proccessImage:(float)gammaMiddle;

@end
