//
//  ProjectController.m
//  Time-Tracker
//
//  Created by Paul Shelley on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ProjectController.h"
#import "Project.h"

static NSString * const ProjectKey = @"projects";

@interface ProjectController ()

@property (nonatomic, strong) NSArray *projects;

@end

@implementation ProjectController

+ (ProjectController *)sharedInstance {
    static ProjectController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ProjectController alloc] init];
    });
    return sharedInstance;
}

- (void)addProject:(Project *)project {

    
}

- (void)removeProject:(Project *)project {
    if (!project) {
        return;
    }
    
    NSMutableArray *mutableProjects = [[NSMutableArray alloc] initWithArray:self.projects];
    [mutableProjects removeObject:project];
    
    self.projects = mutableProjects;
}

- (void)loadFromDefaults {
    NSArray *projectDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:ProjectKey];
    NSMutableArray *projects = [NSMutableArray new];
    for (NSDictionary *dictionary in projectDictionaries) {
        [projects addObject:[[Project alloc] initWithDictionary:dictionary]];
    }
    self.projects = projects;
}

@end
