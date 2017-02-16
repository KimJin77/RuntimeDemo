//
//  ViewController.m
//  RuntimeDemo
//
//  Created by Sim Jin on 2017/2/15.
//  Copyright © 2017年 Jin. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import "Person+Dynamic.h"
#import "NSMutableArray+Dynamic.h"
#import "Animal.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, strong) Person *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titles = @[@"动态添加方法实现", @"动态添加成员变量", @"交换方法的实现", @"替换方法", @"归档", @"字典转模型"];
    self.person = [Person new];
    self.person.name = @"Li Lei";
    self.person.age = 20;
    self.person.job = @"student";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self dynamicAddMethod];
    } else if (indexPath.row == 1) {
        self.person.birthDate = @"19930331";
        NSLog(@"%@", self.person.birthDate);
    } else if (indexPath.row == 2){
        [self.person test1];
        [self.person test2];
    } else if (indexPath.row == 3) {
        NSMutableArray *arr = [NSMutableArray new];
        [arr addObject:nil];
    } else if (indexPath.row == 4) {
        Animal *animal = [Animal new];
        animal.name = @"Lucky";
        animal.age = 2;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:animal];

        Animal *anAnimal = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"%@", anAnimal.name);
    } else {
        NSDictionary *dic = @{@"name": @"Brave", @"age": @3};
        unsigned int count;
        Animal *animal = [Animal new];
        objc_property_t *property = class_copyPropertyList([Animal class], &count);
        for (int i = 0; i < count; i++) {
            const char *propertyName = property_getName(property[i]);
            NSString *key = [NSString stringWithUTF8String:propertyName];
            [animal setValue:dic[key] forKey:key];
        }
        NSLog(@"%@", animal.name);
    }

}

//----------------------------------动态添加方法实现--------------------------------------------------
- (void)dynamicAddMethod {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    class_addMethod([self.person class], @selector(introduction), (IMP)makeAnIntroduction, "v@:");
    if ([self.person respondsToSelector:@selector(introduction)]) {
        [self.person performSelector:@selector(introduction)];
#pragma clang diagnostic pop
    } else {
        NSLog(@"Who am I!?");
    }
}

void makeAnIntroduction(id self, SEL _cmd) {
    if ([self isKindOfClass:[Person class]]) {
        Person *p = (Person *)self;
		NSLog(@"I am %@", p.name);
    }
}
//------------------------------------------------------------------------------------------------




@end
