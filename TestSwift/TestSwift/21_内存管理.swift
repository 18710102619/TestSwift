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

func testMemoryManagement() {

    let p = Person21()
    p.fn = {
        [weak p] in p?.run()
    }

}
