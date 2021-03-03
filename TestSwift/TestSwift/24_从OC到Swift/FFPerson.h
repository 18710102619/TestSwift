//
//  FFPerson.h
//  TestSwift
//
//  Created by 张玲玉 on 2021/3/2.
//

#import <Foundation/Foundation.h>
#import "TestSwift-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface FFPerson : NSObject

@property(nonatomic, assign)NSInteger age;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, strong)FFCar *car;

- (instancetype)initWithAge:(NSInteger)age name:(NSString *)name;
+ (instancetype)personWithAge:(NSInteger)age name:(NSString *)name;

- (void)run;
+ (void)run;

- (void)eat:(NSString *)food other:(NSString *)other;
+ (void)eat:(NSString *)food other:(NSString *)other;

@end

NS_ASSUME_NONNULL_END
