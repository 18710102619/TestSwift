//
//  16_泛型.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/2/24.
//

import Foundation

/*
 泛型
 泛型可以将类型参数化，提高代码复用率，减少代码量
 */
func swapValues<T>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}

/*
 关联类型
 关联类型的作用：给协议中用到的类型定义一个占位名称
 协议中可以拥有多个关联类型
 */
protocol Stackable {
    associatedtype Element //关联类型
    mutating func push(_ element: Element)
    mutating func pop() -> Element
    func top() -> Element
    func size() -> Int
}
class StringStack : Stackable {
    // 给关联类型设定真实类型
    var elements = [String]()
    func push(_ element: String) { elements.append(element) }
    func pop() -> String { elements.removeLast() }
    func top() -> String { elements.last! }
    func size() -> Int { elements.count }
}

/*
 类型约束
 */
protocol Runnable3 { }
class Person33 { }
func swapValues<T:Person & Runnable3>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}


/*
 as  从派生类转换为基类，向上转型（upcasts）
 as! 向下转型（Downcasting）时使用。由于是强制类型转换，如果转换失败会报 runtime 运行错误。
 as? 和 as! 操作符的转换规则完全一样。但 as? 如果转换不成功的时候便会返回一个 nil 对象
 */
protocol Runnable4 { }
class Person44:Runnable4 { }
class Car4:Runnable4 { }
func get<T : Runnable4>(_ type: Int) -> T {
    if type == 0 {
        return Person44() as! T  //非nil
    }
    return Car4() as! T  //非nil
}

/*
 不透明类型
 使用some关键字声明一个不透明类型
 some除了用在返回值类型上，一般还可以在属性类型上
 */
func get2(_ type: Int) -> some Runnable4 {
    //some限制只能返回一种类型
//    if type == 0 {
//        return Car4()
//    }
    return Person44()
}

func testGenerics() {

    var r1: Person44 = get(0)
    var r2: Car4 = get(0)

    var a = 10
    var b = 20
    swapValues(&a, &b)

    var date1 = Date(year: 2011, month: 9, day:10)
    var date2 = Date(year: 2011, month: 9, day:10)
    swapValues(&date1, &date2)
}
