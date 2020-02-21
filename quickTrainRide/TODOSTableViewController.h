//
//  TODOSTableViewController.h
//  quickTrainRide
//
//  Created by Antoine Rabanes on 20/02/2020.
//  Copyright © 2020 Antoine Rabanes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TODOService.h"

NS_ASSUME_NONNULL_BEGIN

@interface TODOSTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

NS_ASSUME_NONNULL_END
