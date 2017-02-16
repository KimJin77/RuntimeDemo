//
//  Person+Dynamic.m
//  RuntimeDemo
//
//  Created by Sim Jin on 2017/2/16.
//  Copyright © 2017年 Jin. All rights reserved.
//

#import "Person+Dynamic.h"
#import <objc/runtime.h>

@implementation Person (Dynamic)

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], @selector(test1));
    Method method2 = class_getInstanceMethod([self class], @selector(test2));
    method_exchangeImplementations(method1, method2);
}

- (void)setBirthDate:(NSString *)date {
    objc_setAssociatedObject(self, "BirthDate", date, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)birthDate {
    return (NSString *)objc_getAssociatedObject(self, "BirthDate");
}

@end
