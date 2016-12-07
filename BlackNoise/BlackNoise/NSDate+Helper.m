//
//  NSDate+Helper.m
//  Ekeo2
//
//  Created by Roger on 13-8-20.
//  Copyright (c) 2013年 Ekeo. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

+ (NSDate*)localizeDate
{
    NSDate* date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    return localeDate;
}

+(NSString*)dateStringFromDate:(NSDate*)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    calendar.locale = [NSLocale currentLocale];
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    
    return [NSString stringWithFormat:@"%d.%d",(int)dateComponents.month, (int)dateComponents.day];
}

+ (NSString*)weakdayFromDate:(NSDate*)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    calendar.locale = [NSLocale currentLocale];
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date];
    
    switch (dateComponents.weekday) {
        case 1:
            return LSTR(@"date_sunday");
            break;
        case 2:
            return LSTR(@"date_monday");
            break;
        case 3:
            return LSTR(@"date_tuesday");
            break;
        case 4:
            return LSTR(@"date_wednesday");
            break;
        case 5:
            return LSTR(@"date_thursday");
            break;
        case 6:
            return LSTR(@"date_friday");
            break;
        case 7:
            return LSTR(@"date_saturday");
            break;
        default:
            return nil;
            break;
    }
}

+ (NSDate*)todayNoon
{
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSDate* todayNoon = [NSDate dateWithTimeIntervalSince1970:(currentTime - (int)currentTime % 86400) + 43200];
    return todayNoon;
}

+ (NSDate*)beginningOfToday
{
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSDate* result = [NSDate dateWithTimeIntervalSince1970:(currentTime - (int)currentTime % 86400)];
    //减去北京时差8个小时，变成0点为起始时间
    
    result = [NSDate dateWithTimeIntervalSince1970:(result.timeIntervalSince1970 - (60 * 60 * 8))];
    return result;
}

+ (NSDate*)beginningOfYesterday
{
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSDate* result = [NSDate dateWithTimeIntervalSince1970:(currentTime - (int)currentTime % 86400  - 86400)];
    return result;
}

+ (NSDate*)beginningOfThisMonth
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    calendar.locale = [NSLocale currentLocale];
    
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    
    dateComponents.day = 1;
    
    NSDate *result = [calendar dateFromComponents:dateComponents];
    
    return result;
}

+ (NSDate*)endingOfThisMonth
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    calendar.locale = [NSLocale currentLocale];
    
    NSDateComponents *currentComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    
    NSInteger day = 1;
    NSInteger month = currentComponents.month;
    NSInteger year = currentComponents.year;
    
    if (month == 12) {
        month = 1;
        year++;
    }
    else {
        month++;
    }
    
    NSDateComponents *nextComponents = [[NSDateComponents alloc] init];
    nextComponents.year = year;
    nextComponents.month = month;
    nextComponents.day = day;
    
    NSDate *nextMonthDate = [calendar dateFromComponents:nextComponents];
    
    return [NSDate dateWithTimeIntervalSince1970:nextMonthDate.timeIntervalSince1970-1];
}

+ (NSString*)lastLoginTimeOfInterval:(int)interval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDate *todayBeginning = [NSDate beginningOfToday];
    NSTimeInterval intervalSinceNow = [[NSDate date] timeIntervalSinceDate:date];
    NSTimeInterval intervalSinceToday = todayBeginning.timeIntervalSince1970 - date.timeIntervalSince1970;
    
    if (intervalSinceNow < 60) {
        return LSTR(@"just_now");
    }
    else if (intervalSinceNow < 60 * 60)
    {
        return [NSString stringWithFormat:@"%d%@", (int)(intervalSinceNow / 60), LSTR(@"mins_ago")];
    }
    else if (intervalSinceNow < 60 * 60 * 4)
    {
        return [NSString stringWithFormat:@"%d%@", (int)(intervalSinceNow / 3600), LSTR(@"hours_ago")];
    }
    else if (intervalSinceToday < 0)
    {
        return [JRDFFactoryInstance stringWithFormat:@"H:mm" date:date];
    }
    else if (intervalSinceToday < 60 * 60 * 24)
    {
        return LSTR(@"yesterday");
    }
    else
    {
        return [NSString stringWithFormat:@"%d%@", (int)(intervalSinceToday / 86400) + 1, LSTR(@"days_ago")];
    }
}

+ (NSString*)feedTimeOfInterval:(double)interval
{
    if (interval == 0) {
        return @"";
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDate *todayBeginning = [NSDate beginningOfToday];
    NSTimeInterval intervalSinceNow = [[NSDate date] timeIntervalSinceDate:date];
    NSTimeInterval intervalSinceToday = todayBeginning.timeIntervalSince1970 - date.timeIntervalSince1970;
    
    date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    if (intervalSinceToday > 60 * 60 * 24 * 7)
    {
        NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:date];
        NSDateComponents *nowComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit  fromDate:[NSDate date]];
        
        if ([dateComponents year] == [nowComponents year]) {
            return [JRDFFactoryInstance stringWithFormat:LSTR(@"date_format_MdHmm") date:date];
        }
        else
        {
            return [JRDFFactoryInstance stringWithFormat:LSTR(@"date_format_yyyyMdHmm") date:date];
        }
    }
    else if (intervalSinceToday > 60 * 60 * 24)
    {
        return [NSString stringWithFormat:@"%d%@", (int)(intervalSinceToday / 86400) + 1 , LSTR(@"days_ago")];
    }
    else if (intervalSinceToday > 0)
    {
        return LSTR(@"yesterday");
    }
    else if (intervalSinceNow > 60 * 60)
    {
        return  [JRDFFactoryInstance stringWithFormat:@"H:mm" date:date];
    }
    else if (intervalSinceNow > 60)
    {
        return [NSString stringWithFormat:@"%d%@", (int)(intervalSinceNow / 60) , LSTR(@"mins_ago")];
    }
    else
    {
        return LSTR(@"just_now");
    }
}

+ (NSString*)commentTimeOfInterval:(double)interval
{
    NSDateFormatter *dateTimeFormatter = [JRDFFactoryInstance dateFormatterWithFormat:LSTR(@"date_format_MdHmm")];
    NSDateFormatter *yearDateFormatter = [JRDFFactoryInstance dateFormatterWithFormat:LSTR(@"date_format_yyyyMd")];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDate *todayBeginning = [NSDate beginningOfToday];
    NSTimeInterval intervalSinceNow = [[NSDate date] timeIntervalSinceDate:date];
    NSTimeInterval intervalSinceToday = todayBeginning.timeIntervalSince1970 - date.timeIntervalSince1970;
    
    date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    if (intervalSinceToday > 60 * 60 * 24 * 7)
    {
        NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:date];
        NSDateComponents *nowComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit  fromDate:[NSDate date]];
        
        if ([dateComponents year] == [nowComponents year]) {
            return [dateTimeFormatter stringFromDate:date];
        }
        else
        {
            return [yearDateFormatter stringFromDate:date];
        }
    }
    else if (intervalSinceToday > 60 * 60 * 24)
    {
        return [NSString stringWithFormat:@"%d%@", (int)(intervalSinceToday / 86400) + 1, LSTR(@"days_ago")];
    }
    else if (intervalSinceToday > 0)
    {
        return LSTR(@"yesterday");
    }
    else if (intervalSinceNow > 60 * 60)
    {
        return [JRDFFactoryInstance stringWithFormat:@"H:mm" date:date];
    }
    else if (intervalSinceNow > 60)
    {
        return [NSString stringWithFormat:@"%d%@", (int)(intervalSinceNow / 60), LSTR(@"mins_ago")];
    }
    else
    {
        return LSTR(@"just_now");
    }
}

+ (NSString*)crewEventTimeOfInterval:(double)interval
{
    return [JRDFFactoryInstance stringWithFormat:@"yyyy-MM-dd HH:mm" intervalSince1970:interval];
}

+ (NSString*)crewEventTimeInDayOfInterval:(double)interval
{
    return [JRDFFactoryInstance stringWithFormat:@"H:mm" intervalSince1970:interval];
}

+ (int)dayCountForMonth:(int)month andYear:(int)year
{
    if (month==1||month==3||month==5||month==7||month==8||month==10||month==12) {
        return 31;
    }else if(month==4||month==6||month==9||month==11){
        return 30;
    }else if([self isLeapYear:year]){
        return 29;
    }else{
        return 28;
    }
}

+ (BOOL)isLeapYear:(int)year
{
    if (year%400==0) {
        return YES;
    }else{
        if (year%4==0&&year%100!=0) {
            return YES;
        }else{
            return NO;
        }
    }
}

+ (int)dayInMonthOfInterval:(double)interval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:date];
    
    NSInteger day = [components day];
    
    return (int)day;
}

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    return [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year] == [comp2 year];
}

+ (NSString*)logTime
{
    return  [JRDFFactoryInstance stringWithFormat:@"M-d H:mm:ss" date:[NSDate date]];
}

+ (NSString*)runRecordTime:(double)interval
{
    if (interval == 0) {
        return @"";
    }
    return [JRDFFactoryInstance stringWithFormat:@"yyyy-M-d H:mm" intervalSince1970:interval];
}

+ (NSString*)simpleDate:(double)interval
{
    if (interval == 0) {
        return @"";
    }
    return [JRDFFactoryInstance stringWithFormat:@"yyyy-M-d " intervalSince1970:interval];
}

+ (int)getTotalMinutesInOneDayFromDate:(NSDate *)date
{
    NSDateComponents* dateComponents = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:date];
    int minutes = (int) dateComponents.hour*60 + (int)dateComponents.minute;
    return minutes;
}

+ (NSString *)formatTime:(NSString *)tm withFormat:(NSString *)format beijing:(BOOL)beijing
{
    NSDate *newDate  = [NSDate dateWithTimeIntervalSince1970:[tm doubleValue]];
    NSDateFormatter *dateFormatter;
    if (beijing)
    {
        dateFormatter = [NSDate beiJingDateFormatter];
    }
    else
    {
        dateFormatter = [[NSDateFormatter alloc] init]; //TODO: USE JRDFFactoryInstance to create  NSDateFormatter
    }
    
    [dateFormatter setDateFormat:format];
    NSString *showtimeNew = [dateFormatter stringFromDate:newDate];
    return showtimeNew;
}

+ (NSString *)formatDateStartToEnd:(int)starttime endtime:(int)endtime
{
    NSString *startStr = [JRDFFactoryInstance stringWithFormat:@"yyyy/MM/dd HH:mm" intervalSince1970:starttime];
    NSString *endStr = [JRDFFactoryInstance stringWithFormat:@"HH:mm" intervalSince1970:endtime];
    
    return [NSString stringWithFormat:@"%@ - %@", startStr, endStr];
}

+ (NSDateFormatter *)beiJingDateFormatter
{
    //TODO: USE JRDFFactoryInstance to create  NSDateFormatter
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_HK"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT+08:00"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setCalendar:calendar];
    [dateFormatter setLocale:locale];
    [dateFormatter setTimeZone:gmt];
    
    return dateFormatter;
}

+ (int)getYearWithTime:(long long)lasttime beijing:(BOOL)beijing
{
    int year = [[NSDate formatTime:LL2STR(lasttime) withFormat:@"yyyy" beijing:beijing] intValue];
    return year;
}

+ (int)getMonthWithTime:(long long)lasttime beijing:(BOOL)beijing
{
    int month = [[NSDate formatTime:LL2STR(lasttime) withFormat:@"MM" beijing:beijing] intValue];
    return month;
}

+ (int)getDayWithTime:(long long)lasttime beijing:(BOOL)beijing
{
    int day = [[NSDate formatTime:LL2STR(lasttime) withFormat:@"dd" beijing:beijing] intValue];
    return day;
}

+ (int)getHourWithTime:(long long)lasttime beijing:(BOOL)beijing {
    int hour = [[NSDate formatTime:LL2STR(lasttime) withFormat:@"HH" beijing:beijing] intValue];
    return hour;
}

+ (int)getCurrentYear
{
    NSDate *date = [NSDate date];
    long long time = (long long)[date timeIntervalSince1970];
    return [NSDate getYearWithTime:time beijing:NO];
}

+ (int)getCurrentMonth
{
    NSDate *date = [NSDate date];
    long long time = (long long)[date timeIntervalSince1970];
    return [NSDate getMonthWithTime:time beijing:NO];
}


#pragma mark - Comparaison (From JTDateHelper)
static NSCalendar *_calendar;
+ (void)initializeCalendar {
    if (!_calendar) {
#ifdef __IPHONE_8_0
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
        _calendar.timeZone = [NSTimeZone localTimeZone];
        _calendar.locale = [NSLocale currentLocale];
    }
}
+ (void)releaseCalendar {
    if (_calendar) {
        _calendar = nil;
    }
}

+ (BOOL)date:(NSDate *)dateA isTheSameMonthThan:(NSDate *)dateB
{
    [NSDate initializeCalendar];
    NSDateComponents *componentsA = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:dateA];
    NSDateComponents *componentsB = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:dateB];
    
    return componentsA.year == componentsB.year && componentsA.month == componentsB.month;
}

+ (BOOL)date:(NSDate *)dateA isTheSameWeekThan:(NSDate *)dateB
{
    [NSDate initializeCalendar];
    NSDateComponents *componentsA = [_calendar components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:dateA];
    NSDateComponents *componentsB = [_calendar components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:dateB];
    
    return componentsA.year == componentsB.year && componentsA.weekOfYear == componentsB.weekOfYear;
}

+ (BOOL)date:(NSDate *)dateA isTheSameDayThan:(NSDate *)dateB
{
    // Filter
    if (ABS(dateA.timeIntervalSince1970 - dateB.timeIntervalSince1970) > 1.5 * 86400) { // 1.5 day difference
        return NO;
    }
    
    [NSDate initializeCalendar];
    NSDateComponents *componentsA = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateA];
    NSDateComponents *componentsB = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateB];
    
    return componentsA.year == componentsB.year && componentsA.month == componentsB.month && componentsA.day == componentsB.day;
}

+ (BOOL)date:(NSDate *)dateA isEqualOrBefore:(NSDate *)dateB
{
    if([dateA compare:dateB] == NSOrderedAscending || [NSDate date:dateA isTheSameDayThan:dateB]){
        return YES;
    }
    
    return NO;
}

+ (BOOL)date:(NSDate *)dateA isEqualOrAfter:(NSDate *)dateB
{
    if([dateA compare:dateB] == NSOrderedDescending || [NSDate date:dateA isTheSameDayThan:dateB]){
        return YES;
    }
    
    return NO;
}

+ (BOOL)date:(NSDate *)date isEqualOrAfter:(NSDate *)startDate andEqualOrBefore:(NSDate *)endDate
{
    if (date.timeIntervalSince1970 >= startDate.timeIntervalSince1970 && date.timeIntervalSince1970 < endDate.timeIntervalSince1970) {
        return YES;
    }
    else if([NSDate date:date isEqualOrAfter:startDate] && [NSDate date:date isEqualOrBefore:endDate]){
        return YES;
    }
    
    return NO;
}

+ (long)monthCountBetween:(NSDate*)dateA andDate:(NSDate*)dateB {
    if (!dateA || !dateB) {
        return 0;
    }
    [NSDate initializeCalendar];
    NSDateComponents *componentsA = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateA];
    NSDateComponents *componentsB = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateB];
    long yearCount = componentsA.year - componentsB.year;
    long monthCount = componentsA.month - componentsB.month;
    return -(monthCount + 12 * yearCount);
}

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

+ (long)indexOfMonthFor:(NSDate*)date between:(NSDate*)beginDate andDate:(NSDate*)endDate {
    if (!date || !beginDate || !endDate) {
        return 0;
    }
    [NSDate initializeCalendar];
    long monthCountWithBeginDate = [NSDate monthCountBetween:date andDate:beginDate];
    if (monthCountWithBeginDate > 0) {
        return 0;
    }
    long monthCountWithEndDate = [NSDate monthCountBetween:date andDate:endDate];
    if (monthCountWithEndDate < 0) {
        return [NSDate monthCountBetween:beginDate andDate:endDate];
    }
	
    return -monthCountWithBeginDate;
}


#pragma mark - Date calculating
- (NSDate*)dateByAddMonths:(long)monthCounts {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:monthCounts];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateByAddingComponents:dateComponents toDate:self options:0];
    return date;
}

- (NSDate*)dateByAddDays:(long)dayCounts {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dayCounts];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateByAddingComponents:dateComponents toDate:self options:0];
    return date;
}

// MARK: may has same ability as  "+ (NSDate*)beginningOfToday"
- (NSDate*)todayBegining {
    return [self sameDayWithHour:0 mimute:0 second:0];
}
- (NSDate*)todayEnding {
    return [self sameDayWithHour:23 mimute:59 second:59];
}

- (NSDate*)sameDayWithHour:(NSInteger)hour mimute:(NSInteger)min second:(NSInteger)sec {
    [NSDate initializeCalendar];
    NSDateComponents *components = [_calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    [components setHour:hour];
    [components setMinute:min];
    [components setSecond:sec];
    return [_calendar dateFromComponents:components];
}

- (NSInteger)integerOfUnit:(NSCalendarUnit)unit {
    [NSDate initializeCalendar];
    NSDateComponents *components = [_calendar components:unit fromDate:self];
    if (ISIOS8) {
        return [components valueForComponent:unit];
    }
    
    if (components && unit == NSCalendarUnitEra) {
        return components.era;
    }
    if (components && unit == NSCalendarUnitYear) {
        return components.year;
    }
    if (components && unit == NSCalendarUnitMonth) {
        return components.month;
    }
    if (components && unit == NSCalendarUnitWeekday) {
        return components.weekday;
    }
    if (components && unit == NSCalendarUnitWeekdayOrdinal) {
        return components.weekdayOrdinal;
    }
    if (components && unit == NSCalendarUnitWeekOfMonth) {
        return components.weekOfMonth;
    }
    if (components && unit == NSCalendarUnitWeekOfYear) {
        return components.weekOfYear;
    }
    if (components && unit == NSCalendarUnitYearForWeekOfYear) {
        return components.yearForWeekOfYear;
    }
    if (components && unit == NSCalendarUnitQuarter) {
        return components.quarter;
    }
    if (components && unit == NSCalendarUnitHour) {
        return components.hour;
    }
    if (components && unit == NSCalendarUnitMinute) {
        return components.minute;
    }
    if (components && unit == NSCalendarUnitSecond) {
        return components.second;
    }
    if (components && unit == NSCalendarUnitNanosecond) {
        return components.nanosecond;
    }
    
    
    return 0;
}


@end
