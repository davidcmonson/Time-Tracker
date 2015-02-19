//
//  Project.m
//  Time-Tracker
//
//  Created by Paul Shelley on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Project.h"
#import "WorkPeriods.h"
#import "ProjectController.h"

static NSString * const TitleKey = @"title";

static NSString * const EntryKey = @"entry";

@interface Project ()

@property (nonatomic, strong) WorkPeriods *entry;

@end

@implementation Project

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        self.title = dictionary[TitleKey];
        NSMutableArray *entries = [NSMutableArray new];
        for (NSDictionary *entry in dictionary[EntryKey] ) {
            [entries addObject:[[WorkPeriods alloc] initWithDictionary:entry]];
        }
        self.entries = entries;
    }
    return self;
}

- (NSDictionary *)projectDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    if (self.title) {
        dictionary[TitleKey] = self.title;
    }
    NSMutableArray *entries = [NSMutableArray new];
    for (WorkPeriods *entry in self.entries) {
        NSDictionary *dictionary = [entry workPeriodsDictionary];
        [entries addObject:dictionary];
    }
    return dictionary;
}

- (void)synchronize {
    [[ProjectController sharedInstance] synchronize];
}

- (void)addEntry:(WorkPeriods *)entry {
    if (!entry) {
        return;
    }
    
    NSMutableArray *mutableEntries = [[NSMutableArray alloc] initWithArray:self.entries];
    [mutableEntries addObject:entry];
    
    self.entries = mutableEntries;
    [self synchronize];
}

- (void)removeEntry:(WorkPeriods *)entry {
    if (!entry) {
        return;
    }
    
    NSMutableArray *mutableEntries = [[NSMutableArray alloc] initWithArray:self.entries];
    [mutableEntries removeObject:entry];
    
    self.entries = mutableEntries;
    [self synchronize];
}



@end
