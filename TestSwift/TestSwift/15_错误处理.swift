//
//  15_错误处理.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/2/23.
//

import Foundation

/*
 自定义错误
 Swift中可以通过Error协议自定义运行时的错误信息
 */
enum SomeError : Error {
    case illegalArg(String)
    case outOfBound(Int, Int)
    case outOfMemory
}
//函数内部通过throw抛出自定义Error，可能会抛出Error的函数必须加上throws声明
func divide(_ num1: Int, _ num2: Int) throws -> Int {
    if num2 == 0 {
        throw SomeError.illegalArg("0不能作为除数")
    }
    return num1 / num2
}

/*
 do-catch
 可以使用都-catch捕获Error
 */
func testDocatch1() {
    do {
        try divide(20, 0)

    } catch let SomeError.illegalArg(msg) {
        print("参数异常：",msg)
    }
    catch { // 加入一个空的catch，用于关闭catch。否则会报错：Errors thrown from here are not handled because the enclosing catch is not exhaustive
    }
}
//抛出Error后，try下一句直到作用域结束的代码都将停止运行
func testDocatch2() {
    do {
        try divide(20, 0)

    } catch let error {
        switch error {
        case let SomeError.illegalArg(msg):
            print("参数异常：",msg)
        default:
            print("其他错误")
        }
    }
}

/*
 rethrows
 rethrows表明：函数本身不会抛出错误，但调用闭包参数抛出错误，那么它会将错误向上抛
 */
func exec(_ fn: (Int, Int) throws -> Int, _ num1: Int, _ num2: Int) rethrows {
    print(try fn(num1, num2))
}

/*
 fatalError

 如果遇到严重问题，希望结束程序运行时，可以直接使用fatalError函数抛出错误（这是无法通过do-catch捕捉的错误）
 使用了fatalError函数，就不需要再写return
 */
func test(_ num: Int) -> Int {
    if num >= 0 {
        return 1
    }
    fatalError("num不能小于0")
}
//在某些不得不实现、但不希望别人调用的方法，可以考虑内部使用fatalError函数
class Person1 { required init() {} }
class Student1 : Person1 {
    required init() { fatalError("不要调用初始化") }
    init(score: Int) {}
}

func testError() throws {

    /*
     局部作用域
     可以使用do实现局部作用域
     */
    do {
        let dog = Dog()
        dog.weight=10
    }
    do {
        let dog = Dog()
        dog.weight=20
    }

    var stu1 = Student1(score:98)
    var stu2 = Student1()

    try exec(divide, 20, 0)

    /*
     try?、try!
     可以使用try?、try!调用可能会抛出Error的函数，这样就不用去处理Error
     */
    var result1 = try? divide(20, 0) //Int? 可空
    var result2 = try? divide(20, 0) //nil 空
    var result3 = try! divide(20, 0) //Int 非空

    //a、b是等价的
    var a = try? divide(20, 0)
    var b: Int?
    do {
        b = try divide(20, 0)
    } catch { b = nil}

    /*
     处理Error
     处理Error的2种方式
     1、通过do-catch捕捉Error
     2、不捕捉Error，在当前函数增加throws声明，Error将自动抛给上层函数
     如果最顶层函数（main函数）依然没有捕捉Error,那么程序将终止
     */
    do {
        //需要使用try调用可能会抛出Error的函数
        print(try divide(20, 0))
    } catch is SomeError {
        print("SomeError")
    }
    catch {}
}
