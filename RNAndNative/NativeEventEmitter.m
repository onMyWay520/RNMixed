//
//  NativeEventEmitter.m
//  RNAndNative
//
//  Created by wuyongchao on 2018/4/27.
//  Copyright © 2018年 杭州拼便宜网络科技有限公司. All rights reserved.
/*如果发送了事件却没有一个listener，那么会收到一个警告。我们可以通过重写RCEventEmitter的startObserving和stopObserving方法，来做一下优化，在还没有监听者时就不用发送事件了：*/

#import "NativeEventEmitter.h"

@implementation NativeEventEmitter
// Will be called when this module's first listener is added.
-(void)startObserving {
    hasListeners = YES;
    // Set up any upstream listeners or background tasks as necessary
}

// Will be called when this module's last listener is removed, or on dealloc.
-(void)stopObserving {
    hasListeners = NO;
    // Remove upstream listeners, stop unnecessary background tasks
}

- (void)calendarEventReminderReceived:(NSNotification *)notification
{
    NSString *eventName = notification.userInfo[@"name"];
    if (hasListeners) { // Only send events if anyone is listening
        [self sendEventWithName:@"EventReminder" body:@{@"name": eventName}];
    }
}
- (NSArray<NSString *> *)supportedEvents
{
    return @[@"EventReminder"];
}
@end
