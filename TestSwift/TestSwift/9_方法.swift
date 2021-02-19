//
//  9_方法.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/2/19.
//

import Foundation

/*
 方法

 枚举、结构体、类都可以定义实例方法、类型方法
 实例方法：通过实例对象调用
 类型方法：通过类型调用，用static或者class关键字定义

 self
 在实例方法中代表实例对象
 在类型方法中代表类型
 */
class Car3 {
    static var cout = 0
    init() {
        Car3.cout += 1
    }
    //在此方法中cout等价于self.cout、Car.self.count、Car.cout
    static func getCount() -> Int { cout }
}

/*
 mutating

 结构体和枚举是值类型，默认情况下，值类型的属性不能被自身的实例方法修改
 在func关键字前加mutating可以允许这种修改行为
 */
struct Point {
    var x = 0.0
    var y = 0.0
    mutating func moveBy(deltaX: Double, deltaY: Double) {
        x += deltaX
        y += deltaY
    }
    //可以消除：函数调用后返回值未被使用的警告⚠️
    @discardableResult mutating func moveX(deltaX: Double) -> Double {
        x += deltaX
        return x
    }
}

func testMethod() {
    var p = Point()
    p.moveX(deltaX: 10)

    let c0 = Car3()
    let c1 = Car3()
    let c2 = Car3()
    print(Car3.getCount())
}
