//
//  6_结构体和类.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/2/1.
//

import Foundation

/*
 结构体与类的本质区别
 结构体是值类型（枚举也是值类型），类是引用类型（指针类型）

 值类型
 值类型赋值给var、let或者给函数传参，是直接将所有内容拷贝一份
 类似于对文件进行copy、paste操作，产生了全新的文件副本。属于深拷贝（deep copy）

 值类型的赋值操作（栈空间）
 在Swift标准库中，为了提升性能，String、Array、Dictionary、Set采取了Copy On Write的技术
 1、比如仅当有"写"操作时，才会真正执行拷贝操作
 2、对于标准库值类型的赋值操作，Swift能确保最佳性能，所有没必要为了保证最佳性能来避免赋值
 建议：不需要修改的，尽量定义成let

 引用类型（堆空间）
 引用赋值给var、let或者给函数传参，是将内存拷贝一份
 类似于制作一个文件的替身（快捷方式、链接），指向的是同一个文件。属于浅拷贝
 */


//** 结构体 **
/*
 1、在Swift标准库中，绝大多数的公开类型都是结构体，而枚举和类只占很小一部分
 2、比如Bool、Int、Double、String、Array、Dictionary等常见类型都是结构体
 3、所有的结构体都有一个编译器自动生成的初始化器（initializer，初始化方法，构造器，构造方法）
 */
func testStruct() {

    struct Date {
        var year: Int  //存储属性
        var month: Int
        var day: Int
    }
    //可以传入所有成员值，用以初始化所有成员
    let date = Date(year: 2019, month: 6, day: 23)
    print(date)

    /*
     结构体的初始化器
     编译器会根据情况，可能会为结构体生成多个初始化器，宗旨是：保证所有成员都有初始化
     */
    struct Point {
        var x: Int?
        var y: Int?

        /*
         自定义初始化器
         一旦在定义结构体时自定义了初始化器，编译器就不会在帮它自动生成其他初始化器
         */
//        init(x: Int, y: Int) {
//            self.x=x
//            self.y=y
//        }
    }
    let p1 = Point(x: 10, y: 10)
    let p2 = Point(x: 10)
    let p3 = Point(y: 10)
    let p4 = Point()
    print(p1, p2, p3, p4)
}

//** 类 **
/*
 1、类的定义和结构体类似，但编译器并没有为类自动生成可以传入成员值的初始化器
 2、如果类的所有成员都在定义的时候指定了初始值，编译器会为类生成无参的初始化器
 */
func testClass() {

    class Point {
        var x: Int = 10
        var y: Int = 20
    }
    let p1 = Point()
    print(p1)

    /*
     枚举、结构体、类都可以定义方法
     一般把定义在枚举、结构体、类内部的函数，叫做方法

     思考：方法占用对象的内存么？
     不占用
     方法的本质就是函数
     方法、函数都存放在代码段
     */
    class Size {
        var width = 10
        var height = 10
        func show() {
            print("width=\(width),height=\(height)")
        }
    }
    let size = Size()
    size.show()
}



