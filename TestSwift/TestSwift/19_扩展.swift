//
//  19_扩展.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/2/25.
//

import Foundation

/*
 扩展
 swift中的扩展，有点类似于OC中的分类（Category）

 扩展可以为枚举、结构体、类、协议添加新功能
 可以添加方法、计算属性、下标、(便捷)初始化器、嵌套类型、协议等等

 扩展不能办到的事情
 1、不能覆盖原有的功能
 2、不能添加存储属性，不能向已有的属性添加属性观察器
 3、不能添加父类
 4、不能添加指定初始化器，不能添加反初始化器
 */

/*
 计算属性、下标、方法、嵌套类型
 */
extension Double {
    var km: Double { self * 1_000.0 }
    var m: Double { self }
}
extension Array {
    subscript(nullable idx: Int) -> Element? {
        if (startIndex..<endIndex).contains(idx) {
            return self[idx]
        }
        return nil
    }
}

/*
 协议、初始化器
 如果希望自定义初始化器的同时，编译器也能够生成默认初始化器
 可以在扩展中编写自己定义初始化器
 required初始化器也不能写在扩展中
 */
class Person19 {
    var age: Int
    var name: String
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
}
extension Person19 : Equatable {
    static func == (left: Person19, right: Person19) -> Bool {
        left.age == right.age && left.name == right.name
    }
    convenience init() {
        self.init(age: 0, name: "")
    }
}

/*
 协议
 如果一个类型已经实现了协议的所有要求，但是还没有声明它遵守了这个协议
 可以通过扩展来让它遵守这个协议
 */
protocol TestProtocol {
    func test()
}
class TestClass {
    func test() {
        print("test")
    }
}

/*
 协议
 扩展可以给协议提供默认实现，也间接实现【可选协议】的效果
 扩展可以给协议【协议中从未声明过的方法】
 */
extension TestProtocol {
    func test() {
        print("默认实现")
    }
}

/*
 泛型
 */
class Stack<E> {
    var elements = [E]() //数组
    func push(_ element: E) {
        elements.append(element)
    }
    func pop() -> E {
        elements.removeLast()
    }
    func size() -> Int {
        elements.count
    }
}
//扩展中依然可以使用原类型中的泛型类型
extension Stack {
    func top() -> E {
        elements.last!
    }
}
//符合条件才扩展
extension Stack : Equatable where E : Equatable {
    static func == (left: Stack, right: Stack) -> Bool {
        left.elements == right.elements
    }
}

func testExtension() {

}
