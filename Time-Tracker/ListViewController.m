//
//  ListViewController.m
//  Time-Tracker
//
//  Created by Paul Shelley on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewDataSource.h"
#import "DetailViewController.h"
#import "ProjectController.h"

@interface ListViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ListTableViewDataSource *dataSource;

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(buttonPressed:)];
    [self.view addSubview:self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Project *project = [ProjectController sharedInstance].projects[indexPath.row];
    DetailViewController *dvc = [DetailViewController new];
    dvc.project = project;
    [self.navigationController pushViewController:dvc animated:YES];
}

- (void)buttonPressed:(id)sender {
    Project *project = [[Project alloc] init];
    [[ProjectController sharedInstance] addProject:project];

    DetailViewController *dvc = [[DetailViewController alloc] init];
    dvc.project = project;
    [self.navigationController pushViewController:dvc animated:YES];
}

@end
