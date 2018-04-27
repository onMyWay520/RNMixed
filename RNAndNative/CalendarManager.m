//
//  CalendarManager.m
//  RNAndNative
//
//  Created by wuyongchao on 2018/4/25.
//  Copyright © 2018年 杭州拼便宜网络科技有限公司. All rights reserved.
//RCTEventDispatcher 类库用于处理事件回调。

#import "CalendarManager.h"
#import "XHToast.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "RCTEventEmitter.h"

/*
 1.RCTBridgeModule
 
 RCTBridgeModule
 在React Native中，如果实现一个原生模块，需要实现RCTBridgeModule”协议，其中RCT就是ReaCT的缩写。
 
 RCT_EXPORT_MODULE()
 如果我们实现了RCTBridgeModule协议，我们的类需要包含RCT_EXPORT_MODULE()宏。这个宏也可以添加一个参数用来指定在Javascript中访问这个模块的名字。如果你不指定，默认就会使用这个Objective-C类的名字。
 
 RCT_EXPORT_METHOD()
 与此同时我们需要声明RCT_EXPORT_METHOD()宏来实现要给Javascript导出的方法，否则React Native不会导出任何方法。
 
 RCT_REMAP_METHOD()
 React Native还定义了一个RCT_REMAP_METHOD()宏，它可以指定Javascript方法名， 当许多方法的第一部分相同的时候用它来避免在Javascript端的名字冲突。
 
 2.NativeModules
 
 在Javascript中如果想调用Native的方法，需要使用RN提供的NativeModules模块，具体代码实例中会给出。
 
 3.NativeAppEventEmitter
 
 这是一个事件监听处理的方法，应用在JS中，可以监听到native调用的事件以及参数
 */
@implementation CalendarManager
//为了实现RCTBridgeModule协议，类需要包含RCT_EXPORT_MODULE()宏。这个宏也可以添加一个参数用来指定在Javascript中访问这个模块的名字。如果不指定，默认就会使用这个Objective-C类的名字。

RCT_EXPORT_MODULE();
@synthesize bridge = _bridge;
/*传值类型
 string (NSString)
 number (NSInteger, float, double, CGFloat, NSNumber)
 boolean (BOOL, NSNumber)
 array (NSArray) 包含本列表中任意类型
 object (NSDictionary) 包含string类型的键和本列表中任意类型的值
 function (RCTResponseSenderBlock)
 */
// 接收传过来的 NSString
RCT_EXPORT_METHOD(addEventOne:(NSString *)name){
    
//    [XHToast showCenterWithText:name];
    NSLog(@"接收传过来的NSString: %@", name);
}
// 接收传过来的 NSString + NSDictionary
RCT_EXPORT_METHOD(addEventTwo:(NSString *)name details:(NSDictionary *)details)
{
    RCTLogInfo(@"接收传过来的NSString+NSDictionary: %@ %@", name, details);
}
// 接收传过来的 NSString + date日期
RCT_EXPORT_METHOD(addEventThree:(NSString *)name date:(NSDate *)date)
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    RCTLogInfo(@"接收传过来的NSString+NSDictionary: %@ %@", name, [formatter stringFromDate:date]);
}
//  对外提供调用方法,演示Callback
//RCTResponseSenderBlock只接受一个参数——传递给JavaScript回调函数的参数数组。
RCT_EXPORT_METHOD(testCallbackEventOne:(NSString *)name callback:(RCTResponseSenderBlock)callback)
{
    NSLog(@"%@",name);
    NSArray *events=@[@"我", @"是", @"永",@"超"]; //准备回调回去的数据
    callback(@[[NSNull null],events]);
//    callback(@[name,events]);

}
//Promises
//  对外提供调用方法,演示Promise使用
/*Promises是ES6中的特性，它的目的是统一为JavaScript提供异步编程的接口，避免Callback地狱，解决了Callback的层层嵌套。更加容易的对异步操作进行控制
 如果桥接原生方法的最后两个参数是RCTPromiseResolveBlock和RCTPromiseRejectBlock，则对应的JS方法就会返回一个Promise对象。
 Resolve和Reject分量是Promise的两种状态，表示已解决和已拒绝，Resolve是正常的执行结果，而Reject会触发catch操作。*/
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
/*
  导出常量
  原生模块可以导出一些常量，这些常量在JavaScript端随时都可以访问。用这种方法来传递一些静态数据，可以避免通过bridge进行一次来回交互。*/
- (NSDictionary *)constantsToExport{
    return @{ @"ValueOne": @"我是从原生定义的~" };
}
/*给Javascript发送事件
 即使没有被JavaScript调用，本地模块也可以给JavaScript发送事件通知。最直接的方式是使用eventDispatcher
*/
RCT_EXPORT_METHOD(RNCallOC){
    [self.bridge.eventDispatcher sendAppEventWithName:@"EventReminder" body:@"永超"];
    
}
RCT_REMAP_METHOD(printDate, date1:(nonnull NSNumber *)d1 date2:(nonnull NSNumber *)d2  event:(RCTResponseSenderBlock)callback){
    NSDate* dt1 = [RCTConvert NSDate:d1];
    NSDate* dt2 = [RCTConvert NSDate:d2];
    NSComparisonResult result = [dt1 compare:dt2];
    NSArray *events;
    switch(result){
        case NSOrderedAscending:
            events=@[@"比较结果开始时间小于结束时间"];
             break;
        case NSOrderedDescending:
            events=@[@"比较结果开始时间大于结束时间"];
             break;
        default:
            events=@[@"比较结果开始时间等于结束时间"];
            break;
    }
    callback(@[[NSNull null], events]);
}
@end
