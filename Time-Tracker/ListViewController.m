//
//  ListViewController.m
//  Time-Tracker
//
//  Created by Paul Shelley on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewDataSource.h"

@interface ListViewController()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ListViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dataSource = [ListTableViewDataSource new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self.dataSource;
    [self.view addSubview:self.tableView];
}

@end
