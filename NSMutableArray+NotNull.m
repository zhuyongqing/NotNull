//
//  NSMutableArray+NotNull.m
//  Mopi
//
//  Created by zhuyongqing on 2017/5/31.
//  Copyright © 2017年 zhuyongqing. All rights reserved.
//

#import "NSMutableArray+NotNull.h"
#import <objc/runtime.h>

@implementation NSMutableArray (NotNull)

+ (void)load{
    Method oldMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(insertObject:atIndex:));
    Method newMethod = class_getInstanceMethod([NSMutableArray class], @selector(zy_insertObject:atIndex:));
    
    method_exchangeImplementations(oldMethod, newMethod);
    
    Method objectMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndex:));
    Method newObjectMethod = class_getInstanceMethod([NSMutableArray class], @selector(zy_objectAtIndex:));
        
    method_exchangeImplementations(objectMethod, newObjectMethod);
    
    
//    Method placeMethod = class_getInstanceMethod(NSClassFromString(@"__NSPlaceholderArray"), @selector(initWithObjects:count:));
//    Method newPlaceMethod = class_getInstanceMethod([NSMutableArray class], @selector(zy_initWithObjects:count:));
}

- (void)zy_insertObject:(id)object atIndex:(NSInteger)index{
    
    if (object == nil) {
        
        ILMLog(@"添加数组为nil%@",object);
        
        return;
    }
    if (index < -0) {
        index = 0;
    }
    [self zy_insertObject:object atIndex:index];
}

- (id)zy_objectAtIndex:(NSInteger)index{
    
    if (index >= self.count) {
        ILMLog(@"%@越界",self);
        return nil;
    }
    return [self zy_objectAtIndex:index];
}


@end
