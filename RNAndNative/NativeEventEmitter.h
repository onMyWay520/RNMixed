//
//  NativeEventEmitter.h
//  RNAndNative
//
//  Created by wuyongchao on 2018/4/27.
//  Copyright © 2018年 杭州拼便宜网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTEventEmitter.h>
@interface NativeEventEmitter : RCTEventEmitter
{
    bool hasListeners;
}
@end
