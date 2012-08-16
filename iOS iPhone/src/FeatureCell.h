//
//  FeatureCell.h
//  Trigger Happy
//
//  Created by Kevin Harrington on 8/15/12.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FeatureCell : UITableViewCell {
    BOOL useDarkBackground;
    
    UIImage *icon;
    NSString *publisher;
    NSString *name;
    float rating;
    NSInteger numRatings;
    NSString *price;
}

@property BOOL useDarkBackground;

@property(retain) UIImage *icon;
@property(retain) NSString *publisher;
@property(retain) NSString *name;
@property float rating;
@property NSInteger numRatings;
@property(retain) NSString *price;

@end