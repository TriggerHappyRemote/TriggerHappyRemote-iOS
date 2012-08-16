//
//  SingleShotScrollingHelpView.m
//  Trigger Happy
//
//  Created by Kevin Harrington on 8/15/12.
//
//

#import "SingleShotScrollingHelpView.h"

@implementation SingleShotScrollingHelpView

+(SingleShotScrollingHelpView *) initForPhone {
    return [[SingleShotScrollingHelpView alloc] init];
}

- (id) init {
    NSArray*    topLevelObjs = nil;
    
    topLevelObjs = [[NSBundle mainBundle] loadNibNamed:@"SingleShotViewControllerInstructions_Phone" owner:self options:nil];
    if (topLevelObjs == nil)
    {
        NSLog(@"Error! Could not load myNib file.\n");
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
