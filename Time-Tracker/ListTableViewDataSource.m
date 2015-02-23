//
//  ListTableViewDataSource.m
//  Time-Tracker
//
//  Created by Paul Shelley on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ListTableViewDataSource.h"
#import "ProjectController.h"
#import "Project.h"

static NSString * const cellIdentifier = @"listCell";

@implementation ListTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ProjectController sharedInstance].projects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    Project *project = [ProjectController sharedInstance].projects[indexPath.row];
    cell.textLabel.text = project.title;
    cell.detailTextLabel.text = project.time;

    return cell;
}

@end
