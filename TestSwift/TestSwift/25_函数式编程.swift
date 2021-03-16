//
//  25_函数式编程.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/3/5.
//

import Foundation

/*
 Swift中$0、$1的实际含义
 Swift自动为闭包提供参数名缩写功能，可以直接通过$0和$1等来表示闭包中第一个第二个参数，
 并且对应的参数类型会根据函数类型来进行判断

 注：可以发现使用$0、$1的话，参数类型可以自动判断，并且in关键字也可以省略，
 也就是只能用写函数体就可以了
 */
func testSorted25() {
    let numbers = [1,2,5,4,3,6,8,7]
    let sortNumbers = numbers.sorted(by: {$0 < $1})
    print("numbers -" + "\(sortNumbers)")
}

/*
 Array的常见操作
 */
func testArray25() {
    let array = [1, 2, 3, 4]

    //[2, 4, 6, 8]
    let array1 = array.map { $0 * 2 }
    print("array1:",array1)
    //[2, 4]
    let array2 = array.filter { $0 % 2 == 0 }
    print("array2:",array2)
    //10
    let array3 = array.reduce(0) { $0 + $1 }
    print("array3:",array3)
    //10
    let array4 = array.reduce(0, +)
    print("array4:",array4)

    //[[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]
    let array5 = array.map { Array.init(repeating: $0, count: $0) }
    print("array5:",array5)
    //[1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
    let array6 = array.flatMap { Array.init(repeating: $0, count: $0) }
    print("array6:",array6)

    let list = ["123","test","jack","-30"]
    //[Optional(123), nil, nil, Optional(-30)]
    let array7 = list.map { Int($0) }
    print("array7:",array7)
    //[123, -30]
    let array8 = list.flatMap { Int($0) }
    print("array8:",array8)
}

/*
 lazy的优化
 */
func testLazy25() {
    let arr = [1,2,3]
    let result = arr.lazy.map {
        (i: Int) -> Int in
        print("mapping \(i)")
        return i*2
    }
    print("begin------")
    print("mapped", result[0])
    print("mapped", result[1])
    print("mapped", result[2])
    print("end------")

    /*
     begin------
     mapping 1
     mapped 2
     mapping 2
     mapped 4
     mapping 3
     mapped 6
     end------
     */
}

/*
 Optional的map和flatMap
 */
func testOptional25() {
    let num1: Int? = 10
    let num2 = num1.map { $0 * 2 }
    //Optional(20)

    let num3: Int? = nil
    let num4 = num3.map { $0 * 2 }
    //nil

    let num22 = num1.map { Optional.some($0 * 2) }
    //Optional(Optional(20))
    let num33 = num1.flatMap { Optional.some($0 * 2) }
    //Optional(20)

    let num222 = (num1 != nil) ? (num1! + 10) : nil
    let num333 = num1.map{ $0 + 10 }
    //num222、num333是等价的

    var fmt = DateFormatter()
    fmt.dateFormat = "yyyy-MM-dd"
    var str: String? = "2011-09-10"
    //old
    var date1 = str != nil ? fmt.date(from: str!) : nil
    print("date1=",date1)
    //new
    var date2 = str.flatMap(fmt.date)
    print("date1=",date2)


    var score: Int? = 98
    //old
    var str1 = score != nil ? "score is \(score!)" : "No score"
    print("str1=",str1)
    //new
    var str2 = score.map { "score is \($0)" ?? "No score"}
    print("str1=",str2)

    struct Person {
        var name: String
        var age: Int

        init?(_ json: [String : Any]) {
            guard let name = json["name"] as? String,
                  let age = json["age"] as? Int else {
                return nil
            }
            self.name = name
            self.age = age
        }
    }

//    var items = [
//        Person(name: "jack", age: 20),
//        Person(name: "rose", age: 21),
//        Person(name: "kate", age: 22)
//    ]
//    //old
//    func getPerson1(_ name: String) -> Person? {
//        let index = items.firstIndex{ $0.name == name }
//        return index != nil ? items[index!] : nil
//    }
//    //new
//    func getPerson1(_ name: String) -> Person? {
//        return items.firstIndex{ $0.name == name }.map { items[$0] }
//    }

    var json: Dictionary? = ["name": "Jack", "age" : 10]
    //old
    var p1 = json != nil ? Person(json!) : nil
    //new
    var p2 = json.flatMap(Person.init)
}

/*
 函数式编程
 函数式编程是一种编程规范，也就是如何编写程序的方法论
 主要思想：把计算过程尽量分解成一系列可复用函数的调用
 主要特征：函数是"第一等公民"
 函数与其他数据类型一样的地位，可以赋值给其他变量，也可以作为函数参数、函数返回值
 */
func add(_ v: Int) -> (Int) -> Int { return { $0 + v } }
func sub(_ v: Int) -> (Int) -> Int { return { $0 - v } }
func multiple(_ v: Int) -> (Int) -> Int { return { $0 * v } }
func divide(_ v: Int) -> (Int) -> Int { return { $0 / v } }
func mod(_ v: Int) -> (Int) -> Int { return { $0 % v } }
// 函数合成
infix operator >>> : AdditionPrecedence
func >>>(_ f1: @escaping (Int) -> Int,
         _ f2: @escaping (Int) -> Int) -> (Int) -> Int{ { f2(f1($0)) } }

/*
 高阶函数
 高阶函数是至少满足下列一个条件的函数：
 1、接受一个活多个函数作为输入（map、filter、reduce等）
 2、返回一个函数
 */
func addH(_ v: Int) -> (Int) -> Int {
    { $0 + v }
}

/*
 柯里化
 什么是柯里化？
 将一个接受多参数的函数变换为一系列只接受单个参数的函数
 */
func add1(_ v1: Int,_ v2: Int) -> Int { v1+v2 }
//add1(10, 20)
func add2(_ v: Int) -> (Int) -> Int { return { $0 + v } }
//add2(10)(20)

func add3(_ v1: Int, _ v2: Int, _ v3: Int) -> Int {
    v1 + v2 + v3
}
prefix func ~<A, B, C, D>(_ fn: @escaping(A, B, C) -> D)
-> (C) -> (B) -> (A) -> D {
    {c in { b in {a in fn(a, b, c)}}}
}

/*
 函子
 像Array、Optional这样支持map运算的类型，称为函子（Functor）
 */
func testFunctional() {

    //print( (~add3)(30)(20)(10) )

    //let fn = add(3) >>> multiple(5) >>> sub(1) >>> mod(10) >>> divide(2)
    //print(fn(num))

    //testLazy25()

    //testArray25()

    //testSorted25()
}


