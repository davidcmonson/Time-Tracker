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
//@property (nonatomic, strong) NSDate *currentProperty;

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
    [dictionary setObject:entries forKey:EntryKey];

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

    NSInteger totalHours = 0;
    NSInteger totalMinutes = 0;

    for (WorkPeriods *entry in self.entries) {

        NSTimeInterval distanceBetweenDates = [entry.clockOut timeIntervalSinceDate:entry.clockIn];

        // First we'll see how many hours
        double secondsInAnHour = 3600;
        NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;

        // We need to subtract out the hours and then see how many minutes
        double secondsInAMinute = 60;
        NSInteger minutesBetweenDates = (distanceBetweenDates - (hoursBetweenDates * secondsInAnHour)) / secondsInAMinute;

        totalHours += hoursBetweenDates;
        totalMinutes += minutesBetweenDates;

    }

    // If the hour or minute total is less than 10, we want a 0 before it in the string

    NSString *hourString = totalHours < 10 ? [NSString stringWithFormat:@"0%ld", (long)totalHours] : [NSString stringWithFormat:@"%ld", (long)totalHours];

    NSString *minuteString = totalMinutes < 10 ? [NSString stringWithFormat:@"0%ld", (long)totalMinutes] : [NSString stringWithFormat:@"%ld", (long)totalMinutes];

    return [NSString stringWithFormat:@"%@:%@", hourString, minuteString];
}


@end
