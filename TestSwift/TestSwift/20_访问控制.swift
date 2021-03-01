//
//  20_访问控制.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/3/1.
//

import Foundation

/*
 访问控制

 在访问权限控制这块，Swift提供了5个不同的访问级别
 1、open：允许在定义实体的模块、其他模块中访问，允许其他模块进行继承、重写（open只能用在类、类成员上）
 2、public：允许在定义实体的模块、其他模块中访问，不允许其他模块进行继承、重写
 3、internal：只允许在定义实体的模块中访问，不允许在其他模块中访问
 4、fileprivate：只允许在定义实体的源文件中访问
 5、private：只允许在定义实体的封闭声明中访问
 绝大部分实体默认都是internal级别

 访问级别的使用标准
 一个实体不可以被更低访问级别的实体定义，比如
 1、变量\常量类型 >= 变量\常量
 2、参数类型、返回值类型 >= 函数
 3、父类 >= 子类
 4、父协议 >= 子协议
 5、原类型 >= typealias
 6、原始值类型、关联值类型 >= 枚举类型
 7、定义类型A时用到的其他类型 >= 类型A

 成员、嵌套类型
 类型的访问级别会影响成员（属性、方法、初始化器、下标）、嵌套类型的默认访问级别
 1、一般情况下，类型为private或fileprivate,那么成员\嵌套类型默认也是private或fileprivate
 2、一般情况下，类型为internal或public,那么成员\嵌套类型默认是internal

 成员的重写
 1、子类重写成员的访问级别必须 >= 子类的访问级别，或者 >= 父类被重写成员的访问级别
 2、父类的成员不能被成员作用域外定义的子类重写

 直接在全局作用域下定义的private等价于fileprivate

 getter、setter
 1、getter、setter默认自动接收它们所属环境的访问级别
 2、可以给setter单独设置一个比getter更低的访问级别，用以限制写的权限

 初始化器
 1、如果一个public类想在另一个模块调用编译生成的默认无参初始化器，必须显示提供public的无参初始化器
    因为public类的默认初始化器是internal级别
 2、required初始化器 >= 它的默认访问级别
 3、如果结构体有private\fileprivate的存储实例属性，那么它的成员初始化器也是private\fileprivate
    否则默认就是internal

 枚举类型的case
 1、不能给enum的每个case单独设置访问级别
 2、每个case自动接收enum的访问级别
 3、public enum定义的case也是public

 协议
 1、协议中定义的要求自动接收协议的访问级别，不能单独设置访问级别
 2、public协议定义的要求也是public
 3、协议实现的访问级别必须 >= 类型的访问级别，或者 >= 协议的访问级别

 扩展
 1、如果有显示设置扩展的访问级别，扩展添加的成员自动接收扩展的访问级别
 2、如果没有显示设置扩展的访问级别，扩展添加的成员的默认访问级别，跟直接在类型中定义的成员一样
 3、可以单独给扩展添加的成员设置访问级别
 4、不能给用于遵守协议的扩展显示设置扩展的访问级别

 在同一文件中的扩展，可以写成类似多个部分的类型声明
 1、在原本的声明中声明一个私有成员，可以在同一文件的扩展中访问它
 2、在扩展中声明一个私有成员，可以在同一文件的其他扩展中、原本声明中访问它
 */

struct Person20 {
    var age: Int
    func run(_ v: Int) {
        print("func run", age, v)
    }
    static func run(_ v: Int) {
        print("func run", v)
    }
}


func testAccessControl() {
    let fn1 = Person20.run
    fn1(10)

    let fn2: (Int) -> () = Person20.run
    fn2(20)

    let fn3: (Person20) -> ((Int) -> ()) = Person20.run
    fn3(Person20(age:18))(30)
}
