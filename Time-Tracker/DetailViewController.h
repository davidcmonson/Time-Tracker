//
//  DetailViewController.h
//  Time-Tracker
//
//  Created by Jason Noah Choi on 2/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Project;

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) Project *project;

@end
