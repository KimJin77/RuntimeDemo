//
//  Person.h
//  RuntimeDemo
//
//  Created by Sim Jin on 2017/2/15.
//  Copyright © 2017年 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nullable, nonatomic, copy) NSString *job;

- (void)test1;
- (void)test2;
@end
