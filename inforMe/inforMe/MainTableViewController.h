//
//  MainTableViewController.h
//  inforMe
//
//  Created by BSSE on 26/05/2016.
//  Copyright © 2016 BSSE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

+(NSArray *) getSubcribed;
@end
