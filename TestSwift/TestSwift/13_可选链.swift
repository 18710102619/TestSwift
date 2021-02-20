//
//  13_可选链.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/2/20.
//

import Foundation

/*
 可选链
 */

class Car1 { var price = 0 }
class Dog { var weight = 0 }
class Person6 {
    var name: String = ""
    var dog: Dog = Dog()
    var car: Car? = Car()
    func age() -> Int { 18 }
    func eat() { print("Person eat") }
    subscript(index: Int) -> Int { index }
}

func testOptionalChaining() {

    let person:Person6? = Person6()
    let age1 = person!.age() //Int
    let age2 = person?.age() //Int?
    let name = person?.name  //String?
    let index = person?[6]   //Int?

    //如果person是nil,不会调用getName()
    func getName() -> String { "Jack" }
    person?.name = getName()

    //如果可选项为nil，调用方法、下标、属性失败，结果为nil
    //如果可选项不为nil，调用方法、下标、属性成功，结果会被包装成可选项
    //如果结果本来就是可选项，不会进行再次包装
    if let _ = person?.eat() { //()?
        print("eat调用成功")
    } else {
        print("eat调用失败")
    }

    //多个？可以链接在一起
    //如果链中任何一个节点是nil，那么整个链就会调用失败
    var dog = person?.dog  //Dog?
    var weight = person?.dog.weight  //Int?

}
