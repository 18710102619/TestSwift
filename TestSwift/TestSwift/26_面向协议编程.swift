//
//  26_面向协议编程.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/3/15.
//

import Foundation

/*
 面向协议编程

 面向协议编程，简称 POP，Protocol
 1、是Swift的一种编程范式，Apple于2015年WWDC提出
 2、在Swift的标准库中，能见到大量POP的影子

 同时，Swift也是一门面向对象的编程，简称 OOP，Object
 在Swift开发中，OOP和POP是相辅相成的，任何一方并不能取代另一方
 POP能弥补OOP一些设计上的不足

 POP的注意点
 1、优先考虑创建协议，而不是父类（基类）
 2、优先考虑值类型（struct、enum），而不是引用类型（class）
 3、巧用协议的扩展功能
 4、不要为了面向协议而使用协议
 */

var str = "1234567890"

struct FF<Base> {
    var base: Base
    init(_ base: Base) {
        self.base=base
    }
}
//利用协议扩展前缀属性
protocol FFCompatiable {}
extension FFCompatiable {
    var ff: FF<Self> { FF(self) }
    static var ff: FF<Self>.Type { FF<Self>.self }
}
//给字符串扩展功能
//让String拥有mj前缀属性
extension NSString: FFCompatiable {}
//给String.mj、String().mj前缀扩展功能
extension FF where Base : NSString {
    var numberCount: Int {
        var count = 0
        for c in base as String where ("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
    static func test() {

    }
}

class Person26 {}
extension  Person26: FFCompatiable {}
//Person26 或者 继承自Person26
extension FF where Base : Person26 {
    func run() {
        print("跑步")
    }
}

//判断是否是数组
func isArray(_ value: Any) -> Bool {
    //value is Array<Any>
    value is [Any]
}
//判断是否是数组类型
protocol ArrayType {}
extension Array: ArrayType {}
extension NSArray: ArrayType {}
func isArrayType(_ type: Any.Type) -> Bool {
    type is ArrayType.Type
}

func testPOP() {

    print( isArrayType( NSArray.self ))
    print( isArrayType( NSMutableArray.self ))
    print("----------------")

    print( isArray( [1,2] ))
    print( isArray( ["1",2] ))
    print( isArray( NSArray() ))
    print( isArray( NSMutableArray() ))
    print( isArray( "23123" ))
    print("----------------")

    let persoon = Person26()
    persoon.ff.run()
    print(str.ff.numberCount)
    print("12345678".ff.numberCount)
}
