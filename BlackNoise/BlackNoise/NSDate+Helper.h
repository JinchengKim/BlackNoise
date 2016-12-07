//
//  NSDate+Helper.h
//  Ekeo2
//
//  Created by Roger on 13-8-20.
//  Copyright (c) 2013年 Ekeo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)

+ (NSDate*)localizeDate;
+ (NSString*)dateStringFromDate:(NSDate*)date;
+ (NSString*)weakdayFromDate:(NSDate*)date;
+ (NSDate*)todayNoon;
+ (NSDate*)beginningOfToday;
+ (NSDate*)beginningOfYesterday;
+ (NSDate*)beginningOfThisMonth;
+ (NSDate*)endingOfThisMonth;

+ (NSString*)lastLoginTimeOfInterval:(int)interval;
+ (NSString*)feedTimeOfInterval:(double)interval;
+ (NSString*)commentTimeOfInterval:(double)interval;
+ (NSString*)crewEventTimeOfInterval:(double)interval;
+ (NSString*)crewEventTimeInDayOfInterval:(double)interval;

+ (int)dayCountForMonth:(int)month andYear:(int)year;
+ (int)dayInMonthOfInterval:(double)interval;

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;

+ (NSString*)logTime;

+ (NSString*)runRecordTime:(double)interval;
+ (NSString*)simpleDate:(double)interval;

+ (int)getTotalMinutesInOneDayFromDate:(NSDate *)date;

+ (NSString *)formatDateStartToEnd:(int)starttime endtime:(int)endtime;
+ (NSString *)formatTime:(NSString *)tm withFormat:(NSString *)format beijing:(BOOL)beijing;
+ (int)getYearWithTime:(long long)lasttime beijing:(BOOL)beijing;
+ (int)getMonthWithTime:(long long)lasttime beijing:(BOOL)beijing;
+ (int)getDayWithTime:(long long)lasttime beijing:(BOOL)beijing;
+ (int)getHourWithTime:(long long)lasttime beijing:(BOOL)beijing;

+ (int)getCurrentYear;
+ (int)getCurrentMonth;

#pragma mark - Comparaison (From JTDateHelper)
+ (void)initializeCalendar;
+ (void)releaseCalendar;
+ (BOOL)date:(NSDate *)dateA isTheSameMonthThan:(NSDate *)dateB;
+ (BOOL)date:(NSDate *)dateA isTheSameWeekThan:(NSDate *)dateB;
+ (BOOL)date:(NSDate *)dateA isTheSameDayThan:(NSDate *)dateB;
+ (BOOL)date:(NSDate *)dateA isEqualOrBefore:(NSDate *)dateB;
+ (BOOL)date:(NSDate *)dateA isEqualOrAfter:(NSDate *)dateB;
+ (BOOL)date:(NSDate *)date isEqualOrAfter:(NSDate *)startDate andEqualOrBefore:(NSDate *)endDate;
/**
 *  Calculate the count of months between dateA and dateB
 *
 *  @param dateA
 *  @param dateB 
 *
 *  @return positive if dateA is ahead dateB, nagitive if dateA is After dateB.
 */
+ (long)monthCountBetween:(NSDate*)dateA andDate:(NSDate*)dateB;

/**
 *  Calculate the count of days between dateA and dateB
 *
 *  @param fromDateTime
 *  @param toDateTime
 *
 *  @return positive if fromDateTime is ahead toDateTime, nagitive if fromDateTime is After toDateTime, Zero if fromDateTime is the same as toDateTime.
 */
+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;

/**
 *  Calculate the date month index in months that start with beginDate and endDate. 
 *  ⚠️: beginDate must be before the EndDate.
 *
 *  @param date      A date that want to calculate for.
 *  @param beginDate Begin date for calculation
 *  @param endDate   End date for calculation.
 *
 *  @return Index in months
 */
+ (long)indexOfMonthFor:(NSDate*)date between:(NSDate*)beginDate andDate:(NSDate*)endDate;

/**
 *  Add months to a Date
 *
 *  @param monthCounts month count
 *
 *  @return A date witch is added months.
 */
- (NSDate*)dateByAddMonths:(long)monthCounts;
- (NSDate*)dateByAddDays:(long)dayCounts;

/**
 *  A date with Begining of this date
 *
 *  @return
 */
- (NSDate*)todayBegining;

/**
 *  A date with Ending of this date
 *
 *  @return
 */
- (NSDate*)todayEnding;

- (NSDate*)sameDayWithHour:(NSInteger)hour mimute:(NSInteger)min second:(NSInteger)sec;

/**
 *  Get the value of unit. NSCalendarUnitCalendar and NSCalendarUnitTimeZone is not support.
 *
 *  @param unit NSCalendarUnit
 *
 *  @return value of unit
 */
- (NSInteger)integerOfUnit:(NSCalendarUnit)unit;
@end
