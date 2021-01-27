//
//  函数.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/1/26.
//

import Foundation

//1.形参默认是let，也只能是let
func sum(v1:Int, v2:Int) -> Int {
    return v1+v2
}

//2.隐式返回
//如果整个函数体是一个单一表达式，那么函数会隐式返回这个表达
func sum1(v1:Int, v2:Int) -> Int {
    v1+v2
}

//3.返回元组：实现多返回值
func calculate(v1:Int, v2:Int) -> (sum:Int, dif:Int, avg:Int) {
    let sum=v1+v2
    return(sum,v1-v2,sum>>1)
}

//4.参数标签
//可以使用下划线 _ 省略参数标签
func sum2(_ v1:Int, _ v2:Int) -> Int {
    return v1+v2
}

//5.默认参数值
//C++的默认参数值有个限制：必须从右往左设置。由于Swift拥有参数标签，因此并没有此类限制
//***但是中间的标签不可以省略***
func check(name:String="张三",age:Int,job:String="码农") {
    print("name=\(name),age=\(age),job=\(job)")
}

//6.可变参数
//一个函数最多只能有一***1个***可变参数
//紧跟在可变参数后面的参数不能省略参数标签
func sum3(_ numbers:Int...) -> Int {
    var total=0
    for item in numbers {
        total+=item
    }
    return total
}

//7.输入输出参数
//可以用inout定义一个输入输出参数：可以在函数内部修改外部实参的值
/*
 可变参数不能标记为inout（错）
 inout参数不能有默认值
 inout参数只能传入可以被多次赋值的
 inout参数的本质是地址传递（引用传递）
 */
func swapValues(_ v1:inout Int,_ v2:inout Int) {
    //方法一
    //let tmp=v1
    //v1=v2
    //v2=tmp
    //方法二
    (v1,v2)=(v2,v1)
}

//8.函数重载
/*
 规则
 1、函数名相同
 2、参数个数不同、参数类型不同、参数标签不同
 注意点
 1、返回值类型与函数重载无关
 2、默认参数值和函数重载一起使用产生二义性时，编译器并不会报错（在C++中会报错）
 3、可变参数、省略参数标签、函数重载一起使用产生二义性时，编译器有可能会报错
 */
//sum4(v1: 10, v2: 20)只会调用第一个
func sum4(v1:Int, v2:Int) -> Int {
    v1+v2
}
func sum4(v1:Int, v2:Int, v3:Int=10) -> Int {
    v1+v2+v3
}

//9.内联函数
//如果开启了编译器优化（Release模式默认会开启优化），编译器会自动将某些函数变成内联函数
//将函数调用展开成函数体
/*
 哪些函数不会被自动内联？
 函数体比较长
 包含递归调用
 包含动态派发
 ....
 @inline
 在Release模式下，编译器已经开启优化，会自动决定哪些函数需要内联，因此没有必要使用 @inline
 */
//永远不会被内联（即使开启了编译优化）
@inline(never) func test1() {
    print("test")
}
//开启编译器优化后，即使代码很长，也会被内联（递归调用函数、动态派发的函数除外）
@inline(__always) func test2() {
    print("test")
}

//10.函数类型
//每一个函数都是有类型的，函数类型由形参类型、返回值类型组成
//定义变量，调用时不需要参数标签
var fn:(Int,Int) -> Int=sum(v1:v2:)

//11.函数类型作为函数返回值
//返回值是函数类型的函数，叫做高阶函数
func next(_ input: Int) -> Int {
    input+1
}
func pre(_ input: Int) -> Int {
    input-1
}
func forward(_ forward: Bool) -> ((Int) -> Int) {
    forward ? next : pre
}

//12.typealias用来给类型起别名
//按照Swift标准库的定义，Void就是空元组()，public typealias Void = ()
typealias Byte = Int8
typealias Short = Int16
typealias Long = Int64

typealias Date = (year:Int, month:Int, day:Int)

func test(_ date: Date) {
    print(date.0) //取元组中的第一个值
    print(date.year)
}

//13.嵌套函数
//将函数定义在函数内部
func forward2(_ forward: Bool) -> ((Int) -> Int) {
    func next(_ input: Int) -> Int {
        input+1
    }
    func pre(_ input: Int) -> Int {
        input-1
    }
    return forward ? next : pre
}


//无返回值
func testMethod() -> Void {

    //13
    print(forward2(true)(3))
    print(forward2(false)(3))
    //12
    test((2021,1,27))
    //11
    print(forward(true)(3))
    print(forward(false)(3))
    //10
    print(fn(2,3))
    //8
    print(sum4(v1: 10, v2: 20))
    //7
    var num1=10
    var num2=20
    swapValues(&num1, &num2)
    print("num1=\(num1),num2=\(num2)")
    //6
    print(sum3(10,20,30,40,50))
    //5
    check(age: 35)
    //4
    let value = sum2(10, 20)
    print(value)
    //3
    let result=calculate(v1: 20, v2: 10)
    print(result.sum)
    print(result.dif)
    print( result.avg)
}


