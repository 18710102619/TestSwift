//
//  12_初始化.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/2/20.
//

import Foundation

/*
 初始化器

 类、结构体、枚举都可以定义初始化器
 类有2种初始化器：指定初始化器、便捷初始化器

 每个类至少有一个指定初始化器，指定初始化器是类的主要初始化器
 默认初始化器总是类的指定初始化器
 类偏向于少量指定初始化器，一个类通常只有一个指定初始化器

 初始化器的相互调用规则
 指定初始化器必须从它的直系父类调用指定初始化器
 便捷初始化器必须从相同的类里调用另一个初始化器
 便捷初始化器最终必须调用一个指定初始化器
 */

/*
 用required修饰指定初始化器，表明其所有子类都必须实现该初始化器（通过继承或者重写实现）
 如果子类重写了required初始化器，也必须加上required，不用加override
 */
class Person2 {
    required init() {}
    init(age : Int) {}
}
class Student2 : Person2 {
    required init() {
        super.init()
    }
}

/*
 属性观察器
 父类的属性在它自己的初始化器中赋值不会触发属性观察器，但在子类的初始化器中赋值会触发属性观察器
 */
class Person3 {
    var age: Int {
        willSet {
            print("willSet", newValue)
        }
        didSet {
            print("didSet", oldValue, age)
        }
    }
    init() {
        self.age = 0
    }
}
class Student3 : Person3 {
    override init() {
        super.init()
        self.age = 1
    }
}

/*
 可失败初始化器

 1、类、结构体、枚举都可以使用init?定义可失败初始化器
 2、不允许同时定义参数标签、参数个数、参数类型相同的可失败初始化器和非可失败初始化器
 3、可以用init!定义隐式解包的可失败初始化器
 4、可失败初始化器可以调用非可失败初始化器，非可失败初始化器调用可失败初始化器需要进行解包
 5、如果初始化器调用一个可失败始化器导致初始化失败，那么整个初始化过程都失败，并且之后的代码都停止执行
 6、可以用一个非可失败初始化器重写一个可失败初始化器，但反过来是不行的
 */
class Person4 {
    var name: String
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

/*
 反初始化器

 deinit叫做反初始化器，类似于C++的析构函数、OC中的dealloc方法
 当类的实例对象被释放内存时，就会调用实例对象的deinit方法

 deinit不接受任何参数，不能写小括号，不能自行调用
 1、父类的deinit能被子类继承
 2、子类的deinit实现执行完毕后会调用父类的deinit
 */
class Person5 {
    deinit {
        print("Person5对象销毁了")
    }
}

func testInit() {
    var student = Student3()
}
