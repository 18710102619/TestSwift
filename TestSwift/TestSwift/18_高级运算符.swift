//
//  18_高级运算符.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/2/24.
//

import Foundation

/*
 运算符重载
 类、结构体、枚举可以为现有的运算符提供自定义的实现，这个操作叫做：运算符重载
 */
struct Point18_1 {
    var x:Int, y:Int
    static func + (p1: Point18_1, p2: Point18_1) -> Point18_1 {
        Point18_1(x: p1.x + p2.x, y: p1.y + p2.y)
    }
}

/*
 Equatable
 要想得知2个实例是否等价，一般做法是遵守Equatable协议，重载 == 运算符
 与此同时，等价于重载了 != 运算符

 Swift为以下类型提供默认的 Equatable 实现
 没有关联类型的枚举
 只拥有遵守 Equatable 协议关联类型的枚举
 只拥有遵守 Equatable 协议存储属性的结构体

 引用类型比较存储的地址值是否相等（是否引用着同一个对象），使用恒等运算符===、!==
 */
struct Point18_2 : Equatable {
    var x:Int, y:Int
}

/*
 Comparable
 要想比较2个实例的大小，一般做法是：
 遵守Comparable协议
 重载相应的运算符
 */
struct Student18 : Comparable {
    var age: Int
    var score: Int
    init(score: Int, age: Int) {
        self.score = score
        self.age = age
    }
    static func < (lhs: Student18, rhs: Student18) -> Bool {
        (lhs.score < rhs.score) || (lhs.score == rhs.score && lhs.age > rhs.age)
    }
}



func testOperator() {

    /* Comparable */
    let stu1 = Student18(score: 100, age: 20)
    let stu2 = Student18(score: 100, age: 18)
    print(stu1 > stu2)

    /* Equatable */
//    var p1 = Point18_2(x: 10, y: 20)
//    var p2 = Point18_2(x: 10, y: 20)
//    print(p1 == p2)
//    print(p1 != p2)

    /* 运算符重载 */
//    let p = Point18_1(x: 10, y: 20) + Point18_1(x: 11, y: 22)
//    print(p)

    /*
     溢出运算符
     Swift的算数运算符出现溢出时会抛出运行时错误
     Swift有溢出运算符（&+、&-、&*），用来支持溢出运算
     */
//    var min = UInt8.min
//    print(min &- 1)
//
//    var max = UInt8.max
//    print(max &+ 1)
//    print(max &* 2)
}
