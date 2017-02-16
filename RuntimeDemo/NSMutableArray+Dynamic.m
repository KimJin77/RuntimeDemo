//
//  NSArray+Dynamic.m
//  RuntimeDemo
//
//  Created by Sim Jin on 2017/2/16.
//  Copyright © 2017年 Jin. All rights reserved.
//

#import "NSMutableArray+Dynamic.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Dynamic)

+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
        Method currentMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(dy_addObject:));
        BOOL addSuccess = class_addMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:), method_getImplementation(currentMethod), method_getTypeEncoding(currentMethod));
        if (addSuccess) {
            class_replaceMethod(NSClassFromString(@"__NSArrayM"), @selector(dy_addObject:), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, currentMethod);
        }
    });

}

- (void)dy_addObject:(id)object {
    if (object) {
        [self dy_addObject:object];
    } else {
        NSLog(@"Nullllll");
    }
}

@end
