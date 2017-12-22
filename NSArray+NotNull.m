//
//  NSArray+NotNull.m
//  Mopi
//
//  Created by zhuyongqing on 2017/5/31.
//  Copyright © 2017年 zhuyongqing. All rights reserved.
//

#import "NSArray+NotNull.h"
#import <objc/runtime.h>

@implementation NSArray (NotNull)

+ (void)load{
    
    Method oldMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndex:));
    Method newMethod = class_getInstanceMethod([NSArray class], @selector(zy_objectAtIndex:));
    
    Method singleMethod = class_getInstanceMethod(NSClassFromString(@"__NSSingleObjectArrayI"), @selector(objectAtIndex:));
    Method newSingle = class_getInstanceMethod([NSArray class], @selector(zySingle_objectAtIndex:));
    
    method_exchangeImplementations(oldMethod, newMethod);
    method_exchangeImplementations(singleMethod, newSingle);
}

- (id)zy_objectAtIndex:(NSInteger)index{
    
    if (index >= self.count) {
        
        ILMLog(@"%@越界",self);
        
        return nil;
    }
    return [self zy_objectAtIndex:index];
    
}

- (id)zySingle_objectAtIndex:(NSInteger)index{
 
    if (index >= self.count) {
        
        ILMLog(@"%@越界",self);
        
        return nil;
    }
    return [self zySingle_objectAtIndex:index];
    
}

@end
