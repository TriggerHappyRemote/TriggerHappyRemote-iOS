//
//  FractionConverter.h
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
