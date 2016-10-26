//
//  ViewController+Swizzling.m
//  WebView
//
//  Created by 魏郭文 on 2016/10/25.
//  Copyright © 2016年 魏郭文. All rights reserved.
//

#import "ViewController+Swizzling.h"
#import <objc/runtime.h>
@implementation UIViewController (Swizzling)

+ (void)load {
    
    //我们只有在开发的时候才需要查看哪个viewController将出现
    //所以在release模式下就没必要进行方法的交换
#ifdef DEBUG
    
    //原本的viewWillAppear方法
    Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
    
    //需要替换成 能够输出日志的viewWillAppear
    Method logViewWillAppear = class_getInstanceMethod(self, @selector(logViewWillAppear:));
    
    //两方法进行交换
    method_exchangeImplementations(viewWillAppear, logViewWillAppear);
    
#endif
    
}

- (void)logViewWillAppear:(BOOL)animated {
    
    NSString *className = NSStringFromClass([self class]);
    
    //在这里，你可以进行过滤操作，指定哪些viewController需要打印，哪些不需要打印
    if ([className hasPrefix:@"UI"] == NO) {
        NSLog(@"%@ will appear",className);
    }
    
    
    //下面方法的调用，其实是调用viewWillAppear
    [self logViewWillAppear:animated];
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
