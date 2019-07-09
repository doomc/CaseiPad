//
//  NSDate+XTExtension.h
//  XTFramework
//
//  Created by Qing Xiubin on 13-8-15.
//  Copyright (c) 2013年 XT. All rights reserved.
//


#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

#define CALENDAR_CURRENT [NSCalendar currentCalendar]
#define CALENDAR_UNIT (\
NSCalendarUnitYear|\
NSCalendarUnitMonth |\
NSCalendarUnitWeekOfYear |\
NSCalendarUnitWeekOfMonth |\
NSCalendarUnitWeekdayOrdinal |\
NSCalendarUnitWeekday |\
NSCalendarUnitDay |\
NSCalendarUnitHour |\
NSCalendarUnitMinute)

#define COMPONENTS(date) [CALENDAR_CURRENT components:CALENDAR_UNIT fromDate:date]


@interface NSDate (XTExtension)

// Decomposing dates
@property (readonly) NSInteger year;
@property (readonly) NSInteger month;
@property (readonly) NSInteger weekOfYear;
@property (readonly) NSInteger weekOfMonth;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger day;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;

// Relative Dates
+ (NSDate *)dateWithWeeksFromNow:(NSUInteger)weeks;
+ (NSDate *)dateWithWeeksBeforeNow:(NSUInteger)weeks;
+ (NSDate *)dateWithDaysFromNow:(NSUInteger)days;
+ (NSDate *)dateWithDaysBeforeNow:(NSUInteger)days;
+ (NSDate *)dateWithHoursFromNow:(NSUInteger)hours;
+ (NSDate *)dateWithHoursBeforeNow:(NSUInteger)hours;
+ (NSDate *)dateWithMinutesFromNow:(NSUInteger)minutes;
+ (NSDate *)dateWithMinutesBeforeNow:(NSUInteger)minutes;

// Comparing Dates
- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;
- (BOOL)isThisMonth;
- (BOOL)isNextMonth;
- (BOOL)isLastMonth;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;

- (BOOL)isEarlierThanDate:(NSDate *)date;
- (BOOL)isLaterThanDate:(NSDate *)date;
- (BOOL)isSameDayAsDate:(NSDate *)date;
- (BOOL)isSameWeekAsDate:(NSDate *)date;
- (BOOL)isSameMonthAsDate:(NSDate *)date;
- (BOOL)isSameYearAsDate:(NSDate *)date;

// Adjusting Dates
- (NSDate *)dateByAddingWeeks:(NSUInteger)weeks;
- (NSDate *)dateBySubtractingWeeks:(NSUInteger)weeks;
- (NSDate *)dateByAddingDays:(NSUInteger)days;
- (NSDate *)dateBySubtractingDays:(NSUInteger)days;
- (NSDate *)dateByAddingHours:(NSUInteger)hours;
- (NSDate *)dateBySubtractingHours:(NSUInteger)hours;
- (NSDate *)dateByAddingMinutes:(NSUInteger)minutes;
- (NSDate *)dateBySubtractingMinutes:(NSUInteger)minutes;
- (NSDate *)dateByAddingYears:(NSUInteger)years;
- (NSDate *)dateBySubtractingYears:(NSUInteger)years;

- (NSDate *)dateAtStartOfYear;
- (NSDate *)dateAtStartOfMonth;
- (NSDate *)dateAtStartOfWeek;
- (NSDate *)dateAtStartOfDay;
- (NSDate *)dateAtStartOfDayWithHour:(NSInteger)hour;

- (NSDate *)lastYear;
- (NSDate *)nextYear;
- (NSDate *)lastMonth;
- (NSDate *)nextMonth;
- (NSDate *) dateAtLastOfMonth;
- (NSDate *) dateAtNextOfMonth;

// Retrieving Intervals
- (NSInteger)weeksAfterDate:(NSDate *)date;
- (NSInteger)weeksBeforeDate:(NSDate *)date;
- (NSInteger)daysAfterDate:(NSDate *)date;
- (NSInteger)daysBeforeDate:(NSDate *)date;
- (NSInteger)hoursAfterDate:(NSDate *)date;
- (NSInteger)hoursBeforeDate:(NSDate *)date;
- (NSInteger)minutesAfterDate:(NSDate *)date;
- (NSInteger)minutesBeforeDate:(NSDate *)date;

@end


@interface NSDate (XTFormate)

- (NSString *)stringWithFormate:(NSString *)formate;

@end