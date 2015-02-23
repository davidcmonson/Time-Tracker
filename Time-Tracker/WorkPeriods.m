//
//  WorkPeriods.m
//  Time-Tracker
//
//  Created by Paul Shelley on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "WorkPeriods.h"

static NSString * const clockIn = @"clockIn";
static NSString * const clockOut = @"clockOut";


@implementation WorkPeriods

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.clockIn = dictionary[clockIn];
        self.clockOut = dictionary[clockOut];
    }
    return self;
}

- (NSDictionary *)workPeriodsDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    if (self.clockIn) {
        dictionary[clockIn] = self.clockIn;
    }
    if (self.clockOut) {
        dictionary[clockOut] = self.clockOut;
    }
    return dictionary;
}



@end
