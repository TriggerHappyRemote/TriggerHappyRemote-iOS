#import <Foundation/Foundation.h>
#import "FeatureCell.h"
#import "RatingView.h"

@interface IndividualSubviewsBasedApplicationCell : FeatureCell
{
    IBOutlet UIImageView *iconView;
    IBOutlet UILabel *publisherLabel;
    IBOutlet UILabel *nameLabel;
    IBOutlet RatingView *ratingView;
    IBOutlet UILabel *numRatingsLabel;
    IBOutlet UILabel *priceLabel;
}

@end
