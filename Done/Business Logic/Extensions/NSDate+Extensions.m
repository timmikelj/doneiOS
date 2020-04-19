//
//  NSDate+Extensions.m
//  Done
//
//  Created by Tim Mikelj on 19/04/2020.
//  Copyright © 2020 Tim Mikelj. All rights reserved.
//

#import "NSDate+Extensions.h"

@implementation NSDate (TimeAgo)

- (NSString *)timeAgo {
    
    NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;

    NSDate *now = [NSDate date];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear|
                                                         NSCalendarUnitMonth|
                                                         NSCalendarUnitWeekOfMonth|
                                                         NSCalendarUnitDay|
                                                         NSCalendarUnitHour|
                                                         NSCalendarUnitMinute|
                                                         NSCalendarUnitSecond)
                                    
                                               fromDate:self
                                                 toDate:now
                                                options:0];

    if (components.year > 0) {
        formatter.allowedUnits = NSCalendarUnitYear;
    } else if (components.month > 0) {
        formatter.allowedUnits = NSCalendarUnitMonth;
    } else if (components.weekOfMonth > 0) {
        formatter.allowedUnits = NSCalendarUnitWeekOfMonth;
    } else if (components.day > 0) {
        formatter.allowedUnits = NSCalendarUnitDay;
    } else if (components.hour > 0) {
        formatter.allowedUnits = NSCalendarUnitHour;
    } else if (components.minute > 0) {
        formatter.allowedUnits = NSCalendarUnitMinute;
    } else {
        formatter.allowedUnits = NSCalendarUnitSecond;
    }

    NSString *formatString = NSLocalizedString(@"%@ ago", @"Used to say how much time has passed. e.g. '2 hours ago'");

    return [NSString stringWithFormat:formatString, [formatter stringFromDateComponents:components]];
}

@end
