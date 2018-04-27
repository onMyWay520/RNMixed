//
//  MyThread.m
//  RNAndNative
//
//  Created by wuyongchao on 2018/4/26.
//  Copyright © 2018年 杭州拼便宜网络科技有限公司. All rights reserved.
//

#import "MyThread.h"

@implementation MyThread
RCT_EXPORT_MODULE()
//methodQueue方法在模块被初始化的时候会被调用一次，然后会被bridge保留
-(dispatch_queue_t)methodQueue{
//    return dispatch_get_main_queue();
     return dispatch_queue_create("com.facebook.React.AsyncLocalStorageQueue", DISPATCH_QUEUE_SERIAL);
}
//对外提供调用方法,演示Thread使用,封装的模块之间共享分发子线程队列，methodQueue方法会在模块被初始化的时候被执行一次，然后会被React Native的桥接机制保存下来，所以你不需要自己保存队列的引用，除非你希望在模块的其它地方使用它。但是，如果你希望在若干个模块中共享同一个队列，则需要自己保存并返回相同的队列实例；仅仅是返回相同名字的队列是不行的。
RCT_EXPORT_METHOD(doSomethingExpensive:(NSString *)param callback:(RCTResponseSenderBlock)callback){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 在后台执行耗时操作
        // You can invoke callback from any thread/queue
        NSString *str=[NSString stringWithFormat:@"耗时操作%@执行完成...",param];
        callback(@[[NSNull null],str]);
    });
}
@end
