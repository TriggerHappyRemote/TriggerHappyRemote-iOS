//
//  FractionConverter.h
//  Trigger Happy Remote
//
//  Created by Kevin Harrington on 1/9/12.
//  Copyright (c) 2012 Trigger Happy, LLC. All rights reserved.
//

// C++ fraction converter
NSString * fractionConverter(float fraction);
 
NSString * fractionConverter(float fraction) {
    
    int milliseconds = (int)((fraction* 1000) - (float)(int)fraction * 1000);
    
    int seconds = (int)fraction;
    
    switch (milliseconds) {
        case 0:
            return [[NSString alloc] initWithFormat:@"%i", (int)fraction];
        case 166:
            return [[NSString alloc] initWithFormat:@"%i/6", 1+seconds*6];
        case 250:
            return [[NSString alloc] initWithFormat:@"%i/4", 1+seconds*4];
        case 333:
            return [[NSString alloc] initWithFormat:@"%i/3", 1+seconds*3];
        case 500:
            return [[NSString alloc] initWithFormat:@"%i/2", 1+seconds*2];
        case 666:
            return [[NSString alloc] initWithFormat:@"%i/3", 2+seconds*3];
        case 750:
            return [[NSString alloc] initWithFormat:@"%i/4", 3+seconds*4];
        case 833:
            return [[NSString alloc] initWithFormat:@"%i/6", 5+seconds*6];
        default:
            return @"|";

    }
}
