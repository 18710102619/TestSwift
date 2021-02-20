//
//  11_继承.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/2/20.
//

import Foundation

/*
 继承

 1、值类型（枚举、结构体）不支持继承，只有类支持继承
 2、没有父类的类，称为基类
 3、swift并没有像OC、Java那样的规定：任何类最终都要继承自个基类
 4、子类可以重写父类的下标、方法、属性，重写必须加上override

 被class修饰的类型方法、下标，允许被子类重写
 被static修饰的类型方法、下标，不允许被子类重写
 */
class Animal {
    func speak() {
        print("Animal speak")
    }
    subscript(index: Int) -> Int {
        return index
    }
}
class Cat : Animal {
    override func speak() {
        print("Cat speak")
    }
    override subscript(index: Int) -> Int {
        return index
    }
}

/*
 重写属性

 1、子类可以将父类的属性（存储、计算）重写为计算属性
 2、子类不可以将父类属性重写为存储属性
 3、只能重写var属性，不能重写let属性
 4、重写时，属性名、类型要一致

 子类重写后的属性权限 不能小于 父类属性的权限
 1、如果父类属性是只读的，那么子类重写后的属性可能是只读的、也可能是可读写的
 2、如果父类属性是可读写的，那么子类重写后的属性也必须是可读写的

 重写类型属性
 1、被class修饰的计算类型属性，可以被子类重写
 2、被static修饰的类型属性（存储、计算），不可以被子类重写

 final
 被final修饰的方法、下标、属性、禁止被重写
 被final修饰的类，禁止被继承
 */
class Circle3 {
    static var radius: Int = 0
    class var diameter: Int {
        set {
            print("设置直径")
            radius = newValue / 2
        }
        get {
            print("获取直径")
            return radius * 2
        }
    }
}
class subCircle : Circle3 {
   override class var diameter: Int {
        set {
            print("子类设置直径")
            super.diameter = newValue > 0 ? newValue : 0
        }
        get {
            print("子类获取直径")
            super.radius=20
            return super.diameter
        }
    }
}

/*
 属性观察器
 可以在子类中为父类属性（除了只读计算属性、let属性）增加属性观察器
 */
class Circle4 {
    var radius: Int = 1
}
class SubCircle2 : Circle4 {
    override var radius : Int {
        willSet {
            print(newValue)
        }
        didSet {
            print(oldValue, radius)
        }
    }
}

func testInHeritance() {

    let c = SubCircle2()
    c.radius = 10

//    var anim:Animal
//    anim = Animal()
//    anim.speak()
//    print(anim[1])
//    print("---------------")
//    anim = Cat()
//    anim.speak()
//    print(anim[2])
}
