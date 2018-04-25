//
//  CalendarManager.m
//  RNAndNative
//
//  Created by wuyongchao on 2018/4/25.
//  Copyright © 2018年 杭州拼便宜网络科技有限公司. All rights reserved.
//

#import "CalendarManager.h"
#import "XHToast.h"

@implementation CalendarManager
RCT_EXPORT_MODULE();
// 接收传过来的 NSString
RCT_EXPORT_METHOD(addEventOne:(NSString *)name){
//    [XHToast showCenterWithText:name];
    NSLog(@"接收传过来的NSString+NSString: %@", name);
}
// 接收传过来的 NSString + NSDictionary
RCT_EXPORT_METHOD(addEventTwo:(NSString *)name details:(NSDictionary *)details)
{
    RCTLogInfo(@"接收传过来的NSString+NSDictionary: %@ %@", name, details);
}
// 接收传过来的 NSString + date日期
RCT_EXPORT_METHOD(addEventThree:(NSString *)name date:(NSDate *)date)
{
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    RCTLogInfo(@"接收传过来的NSString+NSDictionary: %@ %@", name, [formatter stringFromDate:date]);
}
//  对外提供调用方法,演示Callback
RCT_EXPORT_METHOD(testCallbackEventOne:(NSString *)name callback:(RCTResponseSenderBlock)callback)
{
    NSLog(@"%@",name);
    NSArray *events=@[@"1", @"2", @"3",@"4"]; //准备回调回去的数据
    callback(@[[NSNull null],events]);
//    callback(@[name,events]);

}

@end
