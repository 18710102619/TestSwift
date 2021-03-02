//
//  21_内存管理.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/3/1.
//

import Foundation

/*
 内存管理
 跟OC一样，Swift也是采用基于引用计数的ARC内存管理方案（针对堆空间）

 Swift的ARC中有3种引用
 强引用：默认情况下，引用都是强引用
 弱引用：通过weak定义弱引用
 1、必须是可选类型的var，因为实例销毁后，ARC会自动将弱引用设置为nil
 2、ARC自动给弱引用设置nil时，不会触发属性观察器
 无主引用：通过unowned定义无主引用
 1、不会产生强引用，实例销毁后依然存储着实例的内存地址（类似于OC中的unsafe_unretained）
 2、试图在实例销毁后访问无主引用，会产生运行时错误（野指针）

 weak、unowned的使用限制
 weak、unowned只能用在类实例上面

 循环引用reference cycle
 weak、unowned 都能解决循环引用的问题，unowned 要比 weak 少一些性能消耗
 1、在生命周期中可能会变为 nil 的使用 weak
 2、初始化赋值后再也不会变为 nil 的使用 unowned
 */

/*
 闭包的循环引用
 1、闭包表达式默认会对用到的外层对象产生额外的强引用（对外层对象进行了retain操作）
 2、下面代码会产生循环引用，导致Person对象无法释放（看不到Person的deinit被调用）
 3、在闭包表达式的捕获列表声明weak或unowned引用，解决循环引用问题
 4、如果想在定义闭包属性的同时引用self，这个闭包必须是lazy的（因为在实例初始化完毕之后才能引用self）
 5、如果lazy属性是闭包调用的结果，那么不用考虑循环引用的问题(因为闭包调用后，闭包的生命周期就结束了)
 */
class Person21 {
    var age: Int = 0
    //如果lazy属性是闭包调用的结果，那么不用考虑循环引用的问题(因为闭包调用后，闭包的生命周期就结束了)
    lazy var getAge: Int = {
        self.age
    }()
    //如果想在定义闭包属性的同时引用self，这个闭包必须是lazy的（因为在实例初始化完毕之后才能引用self）
    lazy var fn: (() -> ()) = {
        [weak self] in self?.run()
    }
    func run() {
        print("run")
    }
    deinit {
        print("deinit")
    }
}

/*
 @escaping
 1、非逃逸闭包、逃逸闭包，一般都是当做参数传递给函数
 2、非逃逸闭包：闭包调用发生在函数结束前，闭包调用在函数作用域内
 3、逃逸闭包：闭包有可能在函数结束后调用，闭包调用逃离了函数的作用域，需要通过@escaping声明
 */
typealias Fn21 = () -> ()
//fn是非逃逸闭包
func test21_1(_ fn: Fn21) {
    fn()
}
//fn是逃逸闭包
var gFn21: Fn21?
func test21_2(_ fn: @escaping Fn21) {
    gFn21=fn
}
//fn是逃逸闭包
func test21_3(_ fn: @escaping Fn21) {
    DispatchQueue.global().async {
        fn()
    }
}
class Person21_1 {
    var fn: Fn21
    // fn是逃逸闭包
    init(fn: @escaping Fn21) {
        self.fn = fn
    }
    func run() {
        // DispatchQueue.global().async 也是一个逃逸闭包
        // 它用到了实例成员（属性、方法），编译器会强制要求明确写出self
        DispatchQueue.global().async {
            self.fn()
        }
    }
}

/*
 逃逸闭包的注意点
 逃逸闭包不可以捕获inout参数
 */
func other21_1(_ fn: Fn21){
    fn()
}
func other21_2(_ fn: @escaping Fn21){
    fn()
}
func test21_4(value: inout Int) {
    other21_1 {
        value += 1
    }
    //error：逃逸闭包不能捕获inout参数
//    other21_2 {
//        value += 1
//    }
}

/*
 内存访问冲突

 内存访问冲突会在两个访问满足下列条件时发生：
 1、至少一个是写入操作
 2、它们访问的是同一块内存
 3、它们的访问时间重叠（比如在同一个函数内）

 如果下面的条件可以满足，就说明重叠访问结构体的属性时安全的
 1、你只访问实例存储属性，不是计算属性或者类属性
 2、结构体是局部变量而非全局变量
 3、结构体要么没有被闭包捕获要么只被非逃逸闭包捕获
 */
func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
struct Player {
    var name: String
    var health: Int
    var energy: Int
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

/*
 指针
 Swift中也有专门的指针类型，这些都被定性为"Unsafe"（不安全的）
 1、UnsafePointer<Pointee> 类似于 const Pointee *
 2、UnsafeMutablePointer<Pointee> 类似于 Pointee *
 3、UnsafeRawPointer 类似于 const void *
 4、UnsafeMutableRawPointer 类似于 void *
 */
var age = 10
func test21_11(_ ptr:UnsafeMutablePointer<Int>) {
    ptr.pointee += 10
}
func test21_22(_ ptr:UnsafePointer<Int>) {
    print(ptr.pointee)
}
func test21_33(_ ptr:UnsafeMutableRawPointer) {
    ptr.storeBytes(of: 20, as: Int.self)
}
func test21_44(_ ptr:UnsafeRawPointer) {
    print(ptr.load(as: Int.self))
}


func testMemoryManagement() {

    //获得指向堆空间实例的指针
    class Person {}
    var person = Person()
    var ptr = withUnsafePointer(to: &person) { UnsafeRawPointer($0) }
    var heapPtr = UnsafeRawPointer(bitPattern: ptr.load(as: UInt.self))
    print(heapPtr!)

    //获得指向某个变量的指针
//    var age = 11
//    var ptr1 = withUnsafeMutablePointer(to: &age) { $0 }
//    var ptr2 = withUnsafePointer(to: &age) { $0 }
//    ptr1.pointee = 22
//    print(ptr2.pointee)
//    print(age)

    //指针的应用示例
//    let arr = NSArray(objects: 11, 22, 33, 44)
//    arr.enumerateObjects { (obj, idx, stop) in
//        print(idx, obj)
//        if idx == 2 {
//            stop.pointee = true
//        }
//    }
//    for (idx, obj) in arr.enumerated() {
//        print(idx, obj)
//        if idx == 2 {
//            break
//        }
//    }

//    test21_11(&age)
//    test21_22(&age) //20
//    print(age)  //20
//    test21_33(&age)
//    test21_44(&age) //20
//    print(age)  //20

//    var tulpe = (health: 10, energy: 20)
//    balance(&tulpe.health, &tulpe.energy)
//    var holly = Player(name: "Holly", health: 10, energy: 10)
//    balance(&holly.health, &holly.energy)
//
//    var oscar = Player(name: "Oscar", health: 10, energy: 10)
//    var maria = Player(name: "Maria", health: 5, energy: 10)
//    oscar.shareHealth(with: &maria)  //OK
    //oscar.shareHealth(with: &oscar)  //Error

//    let p = Person21()
//    p.fn = {
//        [weak p] in p?.run()
//    }

}
