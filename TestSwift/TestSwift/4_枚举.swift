//
//  4_枚举.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/1/28.
//

import Foundation

//1.关联值
//有时将枚举的成员值跟其他类型的值关联存储在一起，会非常有用
func testValue() {
    enum Password {
        case number(Int, Int, Int, Int)
        case gesture(String)
    }

    var pwd = Password.number(3, 5, 7, 8)
    pwd = .gesture("123456")

    switch pwd {
    case let .number(n1, n2, n3, n4):
        print(n1,n2,n3,n4)
    case let .gesture(str):
        print(str)
    }
}

//2.原始值
//枚举成员可以使用相同类型的默认值预先对应，这个默认值叫做：原始值
//注意：原始值不占用枚举变量的内存
func  testRawValue() {
    enum Grade : String {
        case perfect = "A"
        case great = "B"
        case good = "C"
        case bad = "D"
    }
    print(Grade.perfect.rawValue)
    print(Grade.great.rawValue)
    print(Grade.good.rawValue)
    print(Grade.bad.rawValue)
}

//3.隐式原始值
//如果枚举的原始值类型是Int、String,Swift会自动分配原始值
func  testAssignedRawValue() {
    enum Direction : String {
        case north,south,east,west
    }
    print(Direction.north)
    print(Direction.north.rawValue)

    enum Season : Int {
        case spring,summer,autumn,winter
    }
    print(Season.spring)
    print(Season.spring.rawValue)
}

func testEnum() {
    testAssignedRawValue()
    testRawValue()
    testValue()
}

