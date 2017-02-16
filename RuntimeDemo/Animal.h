//
//  Animal.h
//  RuntimeDemo
//
//  Created by Sim Jin on 2017/2/16.
//  Copyright © 2017年 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;

@end
