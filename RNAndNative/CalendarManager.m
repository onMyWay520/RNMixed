//
//  CalendarManager.m
//  RNAndNative
//
//  Created by wuyongchao on 2018/4/25.
//  Copyright © 2018年 杭州拼便宜网络科技有限公司. All rights reserved.
//

#import "CalendarManager.h"
#import "XHToast.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
@implementation CalendarManager
RCT_EXPORT_MODULE();
@synthesize bridge = _bridge;
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
    NSArray *events=@[@"我", @"是", @"永",@"超"]; //准备回调回去的数据
    callback(@[[NSNull null],events]);
//    callback(@[name,events]);

}
//Promises
//  对外提供调用方法,演示Promise使用
RCT_REMAP_METHOD(testCallbackEventTwo,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject){
    NSArray *events=@[@"one",@"two",@"three"];
    if (events) {
        resolve(events);
    }
    else{
        NSError *error=[NSError errorWithDomain:@"我是Promise回调错误信息..." code:101 userInfo:nil];
        reject(@"no_events", @"There were no events", error);
        
    }
    
}
- (NSDictionary *)constantsToExport
{
    return @{ @"ValueOne": @"我是从原生定义的~" };
}

RCT_EXPORT_METHOD(RNCallOC){
    [self.bridge.eventDispatcher sendAppEventWithName:@"EventReminder" body:@"永超"];
}
@end
