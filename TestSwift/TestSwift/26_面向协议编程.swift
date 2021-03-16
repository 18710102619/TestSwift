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

struct FF {
    var string: String
    init(_ string: String) {
        self.string=string
    }

    func numberCount() -> Int {
        var count = 0
        for c in string where ("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
}

extension String {
    var ff: FF {
        return FF(self)
    }

    func ff_numberCount() -> Int {
        var count = 0
        for c in self where ("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
}

func testPOP() {
    print(str.ff.numberCount())
    print("12345678".ff.numberCount())

    print(str.ff_numberCount())
    print("12345678".ff_numberCount())
}
