//
//  7_闭包.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/2/1.
//

import Foundation

/*
 闭包
 一个函数和它所捕获的变量/常量环境组合起来，称为闭包
 1、一般指定义在函数内部的函数
 2、一般它捕获的是外层函数的局部变量/常量
 */
typealias Fn = (Int) -> Int
func getFn() -> Fn {
    var num = 0
    func plus(_ i:Int) -> Int {
        num += i
        return num
    }
    return plus
}

/*
 可以把闭包想象成是一个类的实例对象
 1、内存在堆空间
 2、捕获的局部变量/常量就是对象的成员（存储属性）
 3、组成闭包的函数就是类内部定义的方法
 */
class Closure {
    var num = 0
    func plus(_ i:Int) -> Int {
        num += i
        return num
    }
}

typealias Fn2 = (Int) -> (Int, Int)
func getFn2() -> (Fn2, Fn2) {
    var num1 = 0
    var num2 = 0
    func plus(_ i: Int) -> (Int, Int) {
        num1 += i
        num2 += i << 1
        return(num1, num2)
    }
    func minus(_ i: Int) -> (Int, Int) {
        num1 -= i
        num2 -= i << 1
        return(num1, num2)
    }
    return(plus, minus)
}

/*
 闭包表达式
 */
func testClosure() {

    var fn1=getFn()
    var fn2=getFn()
    print(fn1(1))
    print(fn2(2))
    print(fn1(3))
    print(fn2(4))
    print(fn1(5))
    print(fn2(6))

    var cs1=Closure()
    var cs2=Closure()
    print(cs1.plus(1))
    print(cs2.plus(2))
    print(cs1.plus(3))
    print(cs2.plus(4))
    print(cs1.plus(5))
    print(cs2.plus(6))

    let (p, m) = getFn2()
    p(5)
    m(4)
    p(3)
    m(2)
}


