//
//  Project.m
//  Time-Tracker
//
//  Created by Paul Shelley on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Project.h"
#import "WorkPeriods.h"

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

- (void)addEntry:(WorkPeriods *)entry {
    if (!entry) {
        return;
    }
    
    NSMutableArray *mutableEntries = [[NSMutableArray alloc] initWithArray:self.entries];
    [mutableEntries addObject:entry];
    
    self.entries = mutableEntries;
    
}

- (void)removeEntry:(WorkPeriods *)entry {
    if (!entry) {
        return;
    }
    
    NSMutableArray *mutableEntries = [[NSMutableArray alloc] initWithArray:self.entries];
    [mutableEntries removeObject:entry];
    
    self.entries = mutableEntries;
    
}

- (NSDictionary *)workPeriodsDictionary {
    return [NSDictionary new];
}

@end
