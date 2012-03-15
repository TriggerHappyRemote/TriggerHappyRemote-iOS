//
//  MoreViewController.m
//  camera-remote
//
//  Created by Kevin Harrington on 2/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"
#import "FaceDetectionViewController.h"

@implementation MoreViewController


- (void) viewWillAppear:(BOOL)animated {
    
}


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Identifier for retrieving reusable cells.
    static NSString *cellIdentifier = @"MyCellIdentifier";
    
    // Attempt to request the reusable cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // No cell available - create one.
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                      reuseIdentifier:cellIdentifier];
    }
    
    // Set the text of the cell to the row index.
    cell.textLabel.text = [NSString stringWithFormat:@"gg%d", indexPath.row];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"slected");
    
    //FaceDetectionViewController * controller = [FaceDetectionViewController init];
    
    //[self.navigationController pushViewController:controller animated:false];
    
}



@end
