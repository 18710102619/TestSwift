//
//  FFPerson.h
//  TestSwift
//
//  Created by 张玲玉 on 2021/3/2.
//

#import <Foundation/Foundation.h>

/*
 OC调用Swift
 Xcode已经默认生成一个用于OC调用Swift的头文件，文件名格式是：{targetName}-Swift.h
 */
//#import "TestSwift-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface FFPerson : NSObject

@property(nonatomic, assign)NSInteger age;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, strong)id car;

- (instancetype)initWithAge:(NSInteger)age name:(NSString *)name;
+ (instancetype)personWithAge:(NSInteger)age name:(NSString *)name;

- (void)run;
+ (void)run;

- (void)eat:(NSString *)food other:(NSString *)other;
+ (void)eat:(NSString *)food other:(NSString *)other;

@end

NS_ASSUME_NONNULL_END
