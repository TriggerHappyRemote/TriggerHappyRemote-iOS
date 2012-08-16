//
//  FeatureCell.m
//  Trigger Happy
//
//  Created by Kevin Harrington on 8/15/12.
//
//

#import "FeatureCell.h"

@implementation FeatureCell

@synthesize useDarkBackground, icon, publisher, name, rating, numRatings, price;

- (void)setUseDarkBackground:(BOOL)flag {
    if (flag != useDarkBackground || !self.backgroundView) {
        useDarkBackground = flag;
        
        NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:useDarkBackground ? @"DarkBackground" : @"LightBackground" ofType:@"png"];
        UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
        self.backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundView.frame = self.bounds;
    }
}

- (void)dealloc {}

@end