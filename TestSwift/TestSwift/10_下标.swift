//
//  10_下标.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/2/19.
//

import Foundation

/*
 下标
 可以给任意类型（枚举、结构体、类）增加下标功能
 语法类似于实例方法、计算属性，本质就是方法（函数）
 */
class Point2 {
    var x = 0.0
    var y = 0.0
    //可以没有set方法，但必须要有get方法
    //如果只有get方法，可以省略get方法
    subscript(index: Int) -> Double {
        set {
            if index == 0 {
                x = newValue
            } else if index == 1 {
                y = newValue
            }
        }
        get {
            if index == 0 {
                return x
            } else if index == 1 {
                return y
            }
            return 0
        }
    }
}

/*
 下标可以是类型方法
 */
class Sum {
    static subscript(v1: Int, v2: Int) -> Int {
        return v1+v2
    }
}

func testSubscript() {

    print(Sum[10,20])

    let p = Point2()
    p[0] = 11.1
    p[1] = 22.2
    print(p.x)
    print(p.y)
    print(p[0])
    print(p[1])
}
