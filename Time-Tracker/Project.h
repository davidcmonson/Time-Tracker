//
//  Project.h
//  Time-Tracker
//
//  Created by Paul Shelley on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WorkPeriods;

@interface Project : NSObject

@property (nonatomic, strong) NSArray *entries;
@property (nonatomic, strong) NSString *title;

- (void)addEntry:(WorkPeriods *)entry;
- (void)removeEntry:(WorkPeriods *)entry;
- (NSDictionary *)projectDictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;
- (void)clockIn;
- (void)clockOut;
- (NSString *)time;

@end
