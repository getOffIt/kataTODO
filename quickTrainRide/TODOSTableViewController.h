//
//  TODOSTableViewController.h
//  quickTrainRide
//
//  Created by Antoine Rabanes on 20/02/2020.
//  Copyright © 2020 Antoine Rabanes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TODOService.h"
#import "TodosStateManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TODOSTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)valueChanged:(UISegmentedControl *)sender;

@end

NS_ASSUME_NONNULL_END
