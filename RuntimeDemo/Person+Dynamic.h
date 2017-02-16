//
//  Person+Dynamic.h
//  RuntimeDemo
//
//  Created by Sim Jin on 2017/2/16.
//  Copyright © 2017年 Jin. All rights reserved.
//

#import "Person.h"

@interface Person (Dynamic)
@property (nonatomic, copy) NSString *birthDate;
@end
