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
@property (nonatomic, strong) NSDate *currentProperty;

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

- (void)setEntries:(NSArray *)entries {
    _entries = entries;
    
    [self synchronize];
}

- (void)addEntry:(WorkPeriods *)entry {
    if (!entry) {
        return;
    }
    
    NSDictionary *dictionary = [entry workPeriodsDictionary];
    
    
    NSMutableArray *mutableEntries = [[NSMutableArray alloc] initWithArray:self.entries];
    [mutableEntries addObject:dictionary];
    
    
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

- (void)clockIn {
    [self startNewEntry];
}

- (void)clockOut {
    [self endCurrentEntry];
}

- (void)startNewEntry {
    WorkPeriods *entry = [WorkPeriods new];
    entry.clockIn = [NSDate date];
    self.entry = entry;
    
    [self addEntry:entry];
}

- (void)endCurrentEntry {
    self.entry.clockOut = [NSDate date];

    [self synchronize];
}

- (NSString *)time {
    return [NSString stringWithFormat:@" - %@", (NSString *)self.entry.clockOut];
}



@end
