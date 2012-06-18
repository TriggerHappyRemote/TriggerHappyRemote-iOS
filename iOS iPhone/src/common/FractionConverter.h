//
//  FractionConverter.h
//  Trigger Happy
//
//  Created by Kevin Harrington on 6/18/12.
//  Copyright (c) 2012 SmugMug. All rights reserved.
//


#import <Foundation/Foundation.h>


// C++ fraction converter
NSString * fractionConverter(float fraction);
 
NSString * fractionConverter(float fraction) {
    
    int milliseconds = (int)((fraction* 1000) - (float)(int)fraction * 1000);
     
    
    switch (milliseconds) {
        case 0:
            return [[NSString alloc] initWithFormat:@"%i", (int)fraction];
        case 166:
            return @"1/6";
        case 250:
            return @"1/4";
        case 333:
            return @"1/3";
        case 500:
            return @"1/2";
        case 666:
            return @"2/3";
        case 750:
            return @"3/4";
        case 833:
            return @"5/6";
        default:
            return @"|";

    }
}
