//
//  TODOSTableViewController.m
//  quickTrainRide
//
//  Created by Antoine Rabanes on 20/02/2020.
//  Copyright © 2020 Antoine Rabanes. All rights reserved.
//

#import "TODOSTableViewController.h"

@interface TODOSTableViewController ()

@property (nonatomic, strong) NSArray<PODOTodo *> *todos;
@property (nonatomic, strong) TODOService *service;
@property (nonatomic, strong) TodosStateManager *todoStateManager;
@end

@implementation TODOSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.todoStateManager = [TodosStateManager new];
    self.service = [TODOService new];
    __weak typeof(self) weakself = self;
    [self.service retrieveLocalTODOSWithCompletionHandler:^(NSArray<PODOTodo *> * _Nonnull podos) {
        [weakself.todoStateManager setTodos:podos];
        [weakself.tableView reloadData];
        [weakself.activityIndicator stopAnimating];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.todoStateManager count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    NSString *title = [self.todoStateManager todos][indexPath.row].title;
    [cell.textLabel setText:title];
    [cell.detailTextLabel setText:[self.todoStateManager todos][indexPath.row].author];
    
    return cell;
}

#pragma mark - UIsegmentedControlActions

- (IBAction)valueChanged:(UISegmentedControl *)sender {
    [self.todoStateManager setState:(TodoFilter)sender.selectedSegmentIndex];
    [self.tableView reloadData];
}

@end
