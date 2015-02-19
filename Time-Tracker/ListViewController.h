//
//  ListViewController.h
//  Time-Tracker
//
//  Created by Paul Shelley on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListTableViewDataSource.h"

@interface ListViewController : UIViewController

@property (nonatomic, strong) ListTableViewDataSource *dataSource;

@end
