//
//  Animal.m
//  RuntimeDemo
//
//  Created by Sim Jin on 2017/2/16.
//  Copyright © 2017年 Jin. All rights reserved.
//

#import "Animal.h"
#import <objc/runtime.h>

@implementation Animal

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
        [aCoder encodeObject:[self valueForKey:ivarName] forKey:ivarName];
    }

    free(ivars);
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        unsigned int count;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
            [self setValue:[aDecoder decodeObjectForKey:ivarName] forKey:ivarName];
        }
        free(ivars);
    }
    return self;
}


@end
