//
//  NSDictionary+NotNull.m
//  Mopi
//
//  Created by zhuyongqing on 2017/5/27.
//  Copyright © 2017年 zhuyongqing. All rights reserved.
//

#import "NSDictionary+NotNull.h"
#import <objc/runtime.h>

@implementation NSDictionary (NotNull)

+ (void)load{
    
    Method originMethod = class_getInstanceMethod(NSClassFromString(@"__NSPlaceholderDictionary"), @selector(initWithObjects:forKeys:count:));
    Method changeMethod = class_getInstanceMethod([NSDictionary class], @selector(zy_initWithObjects:forKeys:count:));
    
    method_exchangeImplementations(originMethod, changeMethod);
}


- (instancetype)zy_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt{
    
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (obj == nil) {
            obj = @"";
            ILMLog(@"key: %@ ******字典值为null*****",key);
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self zy_initWithObjects:safeObjects forKeys:safeKeys count:j];
    
}

@end
