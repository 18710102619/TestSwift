//
//  23_模式匹配.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/3/2.
//

import Foundation

/*
 模式

 1、通配符模式
 _ 匹配任何值
 _? 匹配非nil值

 2、标识符模式
 给对应的变量、常量名赋值

 3、值绑定模式
 赋值

 4、元组模式
 元组
 */
func testPattern() {

    //5、枚举Case模式
    //if case语句等价于只有1个case的switch语句
    let age = 2
    //原来的写法
    if (age >= 0 && age <= 9) {
        print("[0, 9]")
    }
    //枚举Case模式
    if case 0...9 = age {
        print("[0, 9]")
    }
    guard case 0...9 = age else {
        return
    }
    print("[0, 9]")

    //6、可选模式
    let ages: [Int?] = [nil, 2, 3, nil, 5]
    for item in ages {
        if let age = item {
            print(age)
        }
    }

    //7、类型转换模式
    let num: Any = 6
    switch num {
    case is Int:
        // 编译器依然认为num是Any类型
        print("is Int",num)
    default:
        break
    }

    //8、表达式模式
    //表达式模式用在case中
    let point = (1, 2)
    switch point {
    case (0, 0):
        print("(0,0) is at the origin.")
    case (-2...2, -2...2):
        print("(\(point.0),\(point.1) is near the origin.")
    default:
        print("The point is at(\(point.0),\(point.1).")
    }

    //where
    //可以使用where为模式匹配增加匹配条件
    var data = (10, "Jack")
    switch data {
    case let (age, _) where age > 10:
        print(data.1,"age>10")
    case let (age, _) where age > 0:
        print(data.1,"age>0")
    default:
        break
    }
}
