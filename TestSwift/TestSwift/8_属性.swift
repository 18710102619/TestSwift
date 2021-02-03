//
//  8_属性.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/2/1.
//

import Foundation
import SwiftUI

/*
 属性
 Swift中跟实例相关的属性可以分为2大类

 存储属性
 1、类似于成员变量这个概念
 2、存储在实例的内存中
 3、结构体、类可以定义存储属性
 4、枚举不可以定义存储属性

 关于存储属性，Swift有个明确的规定
 在创建类或结构体的实例时，必须为所有的存储属性设置一个合适的初始值
 1、可以在初始化器里为存储属性设置一个初始值
 2、可以分配一个默认的属性值作为属性定义的一部分

---------------------------------------------------------

 计算属性
 1、本质就是方法（函数）
 2、不占用实例的内存
 3、枚举、结构体、类都可以定义计算属性

 set传入的新值默认叫做newValue，也可以自定义
 定义计算属性只能用var，不能用let
 let代表常量：值是一成不变的
 计算属性的值是可能发生变化的（即使是只读计算属性）
 */
struct Circle {
    // 存储属性
    var radius: Double
    // 计算属性
    var diameter: Double {
        set {
            radius = newValue / 2
        }
        get {
            radius*2
        }
    }
}

/*
 枚举rawValue原理
 本质是：只读计算属性
 */
enum TestEnum: Int {
    case test1 = 1, test2 = 2, test3 = 3
    var rawValue: Int {
        switch self {
        case .test1:
            return 10
        case .test2:
            return 11
        case .test3:
            return 12
        }
    }
}

/*
 延迟存储属性
 使用lazy可以定义一个延迟存储属性，在第一次用到属性的时候才会进行初始化

 1、lazy属性必须是var，不能是let
 2、let必须在实例的初始化方法完成之前就拥有值
 3、如果多条线程同时第一次访问lazy属性，无法保证属性只被初始化1次

 延迟存储属性注意点
 当结构体包含一个延迟存储属性时，只有var才能访问延迟存储属性
 因为延迟属性初始化时需要改变结构体的内存
 */
class Car {
    init() {
        print("Car init!")
    }
    func run() {
        print("Car is running!")
    }
}
class Person {
    lazy var car = Car()
    init() {
        print("Person init!")
    }
    func goOut() {
        car.run()
    }
}

/*
 属性观察器
 可以为非lazy的var存储属性设置属性观察器

 willSet会传递新值，默认叫newValue
 didSet会传递旧值，默认叫oldValue
 在初始化器中设置属性值不会触发willSet和didSet
 在属性定义时设置初始值也不会触发willSet和didSet
 */


func testProperty() {

    let  p=Person()
    print("------------")
    p.goOut()

//    print(TestEnum.test3.rawValue)
//
//    let circle=Circle(radius: 5)
//    print(circle.radius)
//    print(circle.diameter)
}
