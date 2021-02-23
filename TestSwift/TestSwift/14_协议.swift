//
//  14_协议.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/2/20.
//

import Foundation

/*
 协议

 1、协议可以用来定义方法、属性、下标的声明，协议可以被枚举、结构体、类遵守（多个协议之间用逗号隔开）
 2、协议中定义方法时不能有默认参数值
 3、默认情况下，协议中定义的内容必须全部都实现

 协议中的属性
 协议中定义属性时必须用var关键字
 实现协议时的属性权限要不小于协议中定义的属性权限
 1、协议定义get、set，用var存储属性或get、set计算属性去实现
 2、协议定义get，用任何属性都可以实现
 */
protocol Drawable {
    var x: Int { get set }
    var y: Int { get }
    func draw()
    subscript(index: Int) -> Int { get set }
}
class Person7 : Drawable {
    var x: Int = 0
    var y: Int = 0
    func draw() {
        print("")
    }
    subscript(index: Int) -> Int {
        get {index}
        set {}
    }
}

/*
 static、class
 为了保证通用，协议中必须用static定义类型方法、类型属性、类型下标
 */
protocol Drawable2 {
    static func draw()
}
class Person8 : Drawable2 {
    class func draw() {
        print("")
    }
}
class Person9 : Drawable2 {
    class func draw() {
        print("")
    }
}

/*
 mutating

 只有将协议中的实例方法标记为mutating
 1、才允许结构体、枚举的具体实现修改自身内存
 2、类在实现方法时不用加mutating，枚举、结构体才需要mutating
 */
protocol Drawable3 {
    mutating func draw()
}
class Size3 : Drawable3 {
    var width: Int = 0
    func draw() {
        width = 10
    }
}
struct Point3 : Drawable3 {
    var x: Int = 0
    mutating func draw() {
        x = 10
    }
}

/*
 init

 协议中还可以定义初始化器init
 非final类实现时必须加上required
 */
protocol Drawable4 {
    init(x: Int, y: Int)
}
class Size4 : Drawable4 {
    required init(x: Int, y: Int) {}
}
//被final修饰的类，禁止被继承
final class Point4 : Drawable4 {
    init(x: Int, y: Int) {}
}

/*
 init

 如果从协议实现的初始化器，刚好是重写了父类的指定初始化器
 那么这个初始化必须同时加required、override
 */
protocol Livable {
    init(age: Int)
}
class Person10 {
    init(age: Int) {}
}
class Student : Person10, Livable {
    required override init(age: Int) {
        super.init(age: age)
    }
}

/*
 init、init？、init！
 协议中定义的init?、init!，可以用init、init?、init!去实现
 协议中定义的init,可以用init、init!去实现
 */
protocol Livable1 {
    init()
    init?(age: Int)
    init!(no: Int)
}

class Person11:Livable {
    required init() {}
    required init(age: Int) {}
    required init!(no: Int) {}
}

/*
 协议的继承
 一个协议可以继承其他协议
 */
protocol Runnable {
    func run()
}
protocol Livable2 : Runnable  {
    func breath()
}
class Person13 : Livable2 {
    func breath() {}
    func run() {}
}

/*
 协议组合
 协议组合，可以包含1个类类型（最多1个）
 */
//接收Person或者其子类的实例
func fn0(obj: Person) {}
//接收遵守Livable协议的实例
func fn1(obj: Livable) {}
//接收同时遵守Livable、Runnable协议的实例
func fn2(obj: Livable & Runnable) {}
//接收同时遵守Livable、Runnable协议的实例，并且是Person或者其子类的实例
func fn3(obj: Person & Livable & Runnable) {}
//接收同时遵守Livable、Runnable协议的实例，并且是Person或者其子类的实例
typealias RealPerson = Person & Livable & Runnable
func fun4(obj: RealPerson) {}

/*
 CaseIterable
 让枚举遵循caseIterable协议，可以实现遍历枚举值
 */
enum Season : CaseIterable {
    case spring, summer, autumn, winter
}

/*
 CustomStringConvertible
 自定义实例的打印字符串
 */
class Person14: CustomStringConvertible, CustomDebugStringConvertible {
    var age = 0
    var description: String { "person_\(age)" }
    var debugDescription: String { "debug_person_\(age)" }
}

func testProtocol() {
    /*
     X.self、X.Type、AnyClass
     X.self是一个元类型的指针，metadata存放着类型相关信息
     X.self属于X.Type类型

     swift有个隐藏的基类：Swift._SwiftObject
     self代表当前类型
     self一般用作返回值类型，限定返回值跟方法调用者必须是同一类型（也可以作为参数类型）
     */
    var anyType:AnyObject.Type = Person.self
    anyType = Student.self

    /*
     is、as?、as!、as
     is用来判断是否为某种类型，as用来做强制类型转换
     */
    let stu2:Any = 10
    print(stu2 is Int) //true
    (stu2 as? Person7)?.draw()

    var data2 = [Any]()
    data2.append(Int("123") as Any)

    /*
     Any、AnyObject
     1、Any：可以代表任意类型（枚举、结构体、类，也包括函数类型）
     2、AnyObject：可以代表任意（类）类型（在协议后面写上：AnyObject代表只有类能遵守这个协议）
     在协议后面写上：class也代表只有类能遵守这个协议
     */
    var stu: Any = 10
    stu = "Jack"
    stu = Student2()

    //创建1个能存放任意类型的数组
    //var data = [Any]()
    var data = [Any]()
    data.append(1)
    data.append(3.14)
    data.append(Student2())
    data.append("Jack")
    data.append({10})

    let p = Person14()
    print(p)
    debugPrint(p)

    let seasons = Season.allCases
    print(seasons.count) //4
    for season in seasons {
        print(season)
    } //spring summer autumn winter
}
