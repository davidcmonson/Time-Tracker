//
//  DetailTableViewDataSource.h
//  Time-Tracker
//
//  Created by Jason Noah Choi on 2/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Project;

@interface DetailTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) Project *project;

@end
