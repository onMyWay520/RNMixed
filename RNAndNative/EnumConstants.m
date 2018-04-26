//
//  EnumConstants.m
//  RNAndNative
//
//  Created by wuyongchao on 2018/4/26.
//  Copyright © 2018年 杭州拼便宜网络科技有限公司. All rights reserved.
//

#import "EnumConstants.h"

@implementation EnumConstants
RCT_EXPORT_MODULE();
- (NSDictionary *)constantsToExport
{
    return @{ @"statusBarAnimationNone" : @(UIStatusBarAnimationNone),
              @"statusBarAnimationFade" : @(UIStatusBarAnimationFade),
              @"statusBarAnimationSlide" : @(UIStatusBarAnimationSlide) };
};

@end
