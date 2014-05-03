//
//  HDRViewController.h
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


@interface HDRViewController : UIViewController {
    UILabel * exposureValueLabel;
    UILabel * numberOfShotsLabel;
    UILabel * shutterLengthLabel;
    __weak IBOutlet UIImageView *background;
}

@property (strong, nonatomic) IBOutlet UILabel *exposureValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfShotsLabel;
@property (strong, nonatomic) IBOutlet UILabel *shutterLengthLabel;

@property (strong, nonatomic) IBOutlet UIImageView *centerEVTick;
@property (strong, nonatomic) IBOutlet UIImageView *pos1EVTick;
@property (strong, nonatomic) IBOutlet UIImageView *neg1EVTick;

@property (retain, nonatomic) IBOutlet UILabel *axis0Label;
@property (retain, nonatomic) IBOutlet UILabel *axis1Label;
@property (retain, nonatomic) IBOutlet UILabel *axis2Label;
@property (retain, nonatomic) IBOutlet UILabel *axis3Label;

@end
