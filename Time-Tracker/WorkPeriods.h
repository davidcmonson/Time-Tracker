//
//  WorkPeriods.h
//  Time-Tracker
//
//  Created by Paul Shelley on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkPeriods : NSObject

@property (nonatomic, strong) NSDate *clockIn;
@property (nonatomic, strong) NSDate *clockOut;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)workPeriodsDictionary;


@end
