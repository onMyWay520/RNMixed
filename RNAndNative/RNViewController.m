//
//  RNViewController.m
//  RNAndNative
//
//  Created by wuyongchao on 2018/4/24.
//  Copyright © 2018年 杭州拼便宜网络科技有限公司. All rights reserved.
//

#import "RNViewController.h"
#import <React/RCTRootView.h>
@interface RNViewController ()

@end

@implementation RNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"RN页面";
    NSString * strUrl = @"http://localhost:8081/index.bundle?platform=ios";
    NSURL * jsCodeLocation = [NSURL URLWithString:strUrl];
    
    RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                                    moduleName:@"RNAndNative"
                                                                                    initialProperties:nil
                                                                                        launchOptions:nil];
    self.view=rootView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
