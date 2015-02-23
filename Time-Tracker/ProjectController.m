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
        [sharedInstance loadFromDefaults];
    });
    return sharedInstance;
}

- (void)setProjects:(NSArray *)projects {
    _projects = projects;

    [self synchronize];
}

- (void)addProject:(Project *)project {
    if (!project) {
        return;
    }
    
    NSMutableArray *mutableProjects = [[NSMutableArray alloc] initWithArray:self.projects];
    [mutableProjects addObject:project];
    
    self.projects = mutableProjects;
    [self synchronize];
}

- (void)removeProject:(Project *)project {
    if (!project) {
        return;
    }
    
    NSMutableArray *mutableProjects = [[NSMutableArray alloc] initWithArray:self.projects];
    [mutableProjects removeObject:project];
    
    self.projects = mutableProjects;
    [self synchronize];
}

- (void)replaceOldProject:(Project *)oldProject withNewProject:(Project *)newProject {
    if (!oldProject || !newProject) {
        return;
    }
    
    NSMutableArray *mutableProject = [[NSMutableArray alloc] initWithArray:self.projects];
    
    if ([mutableProject containsObject:oldProject]) {
        NSUInteger index = [mutableProject indexOfObject:oldProject];
        [mutableProject replaceObjectAtIndex:index withObject:newProject];
    }
    
    self.projects = mutableProject;
}


- (void)loadFromDefaults {
    NSArray *projectDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:ProjectKey];
    NSMutableArray *projects = [NSMutableArray new];
    for (NSDictionary *dictionary in projectDictionaries) {
        [projects addObject:[[Project alloc] initWithDictionary:dictionary]];
    }
    self.projects = projects;
}

- (void)synchronize {
    NSMutableArray *projectDictionaries = [NSMutableArray new];
    for (Project *project in self.projects) {
        NSDictionary *dictionary = [project projectDictionary];
        [projectDictionaries addObject:dictionary];
    }
    [[NSUserDefaults standardUserDefaults] setObject:projectDictionaries forKey:ProjectKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
