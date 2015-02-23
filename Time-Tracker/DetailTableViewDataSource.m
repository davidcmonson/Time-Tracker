//
//  DetailTableViewDataSource.m
//  Time-Tracker
//
//  Created by Jason Noah Choi on 2/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "DetailTableViewDataSource.h"
#import "ProjectController.h"

static NSString * const cellIdentifier = @"detailCell";

@interface DetailTableViewDataSource ()


@end

@implementation DetailTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.project.entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    WorkPeriods *entries = [self.project entries][indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", entries.clockIn, entries.clockOut];

    return cell;
}

@end
