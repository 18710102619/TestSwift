//
//  FFPerson.m
//  TestSwift
//
//  Created by 张玲玉 on 2021/3/2.
//

#import "FFPerson.h"



@implementation FFPerson

- (instancetype)initWithAge:(NSInteger)age name:(NSString *)name {
    if (self = [super init]) {
        self.age=age;
        self.name=name;
        self.car=[[FFCar alloc]initWithPrice:200000 band:@"比亚迪"];
    }
    return self;
}

+ (instancetype)personWithAge:(NSInteger)age name:(NSString *)name {
    return [[FFPerson alloc] initWithAge:age name:name];
}

- (void)run {
    if (_car) {
        [self.car run];
    }
    NSLog(@"%zd %@ -run", _age, _name);
}

+ (void)run {
    [FFCar run];
    NSLog(@"Person +run");
}

- (void)eat:(NSString *)food other:(NSString *)other {
    NSLog(@"%zd %@ -eat %@ %@", _age, _name, food, other);
}

+ (void)eat:(NSString *)food other:(NSString *)other {
    NSLog(@"Person +eat %@ %@", food, other);
}

@end
