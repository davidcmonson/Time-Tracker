//
//  ProjectController.h
//  Time-Tracker
//
//  Created by Paul Shelley on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface ProjectController : NSObject

@property (nonatomic, strong, readonly) NSArray *projects;

+ (ProjectController *)sharedInstance;
- (void)addProject:(Project *)project;
- (void)removeProject:(Project *)project;
- (void)replaceOldProject:(Project *)oldProject withNewProject:(Project *)newProject;
- (void)synchronize;

@end
