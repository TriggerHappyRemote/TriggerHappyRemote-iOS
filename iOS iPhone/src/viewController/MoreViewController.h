//
//  MoreViewController.h
//  Trigger Happy
//
//  Created by Kevin Harrington on 8/15/12.
//
//

#import <UIKit/UIKit.h>
#import "FeatureCell.h"

@interface MoreViewController : UITableViewController
{
	FeatureCell *tmpCell;
    NSArray *data;
	
	// referring to our xib-based UITableViewCell ('IndividualSubviewsBasedApplicationCell')
	UINib *cellNib;
}

@property (nonatomic, retain) IBOutlet FeatureCell *tmpCell;
@property (nonatomic, retain) NSArray *data;

@property (nonatomic, retain) UINib *cellNib;

@end
