//
//  5_可选项.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/1/29.
//

import Foundation

//if语句
func login1(_ info:[String :String]) {
    let username: String
    if let tmp = info["username"] {
        username = tmp
    } else {
        print("请输入用户名")
        return
    }
    let password:String
    if let tmp = info["password"] {
        password = tmp
    } else {
        print("请输入密码")
        return
    }
    print("用户名：\(username)","密码：\(password)","登陆ing")
}

//guard语句
/*
 guard 条件 else {
 // do something
 退出当前作用域
 // return、break、continue、throw、error
 }
 1、当guard语句的条件为false时，就会执行大括号里面的代码
 2、当guard语句的条件为true时，就会跳过guard语句
 3、guard语句特别适合用来“提前退出”
 4、当使用guard语句进行可选项绑定时，绑定的常量（let）、变量（var）也能在外层作用域中使用
 */
func login2(_ info:[String :String]) {
    guard let username=info["username"] else {
        print("请输入用户名")
        return
    }
    guard let password=info["password"] else {
        print("请输入密码")
        return
    }
    print("用户名：\(username)","密码：\(password)","登陆ing")
}

func testOptional() {

    //** ? 可选项 Optional **
    /*
     可选项，一般也叫可选类型，它允许将值设置为nil
     在类型名称后面加一个问号？来定义一个可选项
     */
    var name: String? = "张三"
    name=nil

    //** ! 强制解包 **
    /*
     可选项是对其他类型的一层包装，可以将它理解为一个盒子
     1、如果为nil，那么它是个空盒子
     2、如果不为nil,那么盒子里装的是：被包装类型的数据
     如果要从可选项中取出被包装的数据，需要使用感叹号！进行强制解包
     如果对值为nil的可选项进行强制解包，将会产生运行时错误
     */
    var age: Int? = 10
    let ageInt: Int = age!

    //** 可选项绑定 **
    /*
     可以使用可选项绑定来判断可选项是否包含值
     如果包含就自动解包，把值赋值给一个临时的常量（let）或者变量（var），并返回true，否则返回false
     */
    if let number = Int("123") {
        print("字符串转换整数成功：\(number)")
        //字符串转换整数成功：123
        //number是强制解包之后的Int值
        //number作用域仅限于这个大括号
    } else {
        print("字符串转换整数失败")
    }

    //while循环中使用可选项绑定
    //遍历数组，将遇到的正数都加起来，如果遇到负数或者非数学，停止遍历
    var array = ["10","20","abc","-20","10","30"]
    var index=0
    var sum=0
    while let num = Int(array[index]), num > 0 {
        sum += num
        index += 1
    }
    print(sum)

    //** ?? 空合并运算符 **
    /*
     a??b
     1、a是可选项，b是或者不是可选项，b和a的存储类型必须相同
     2、如果a不为nil，就返回a；如果a为nil，就返回b；如果b不是可选项，返回a时会自动解包
     */
    //??是if let配合使用
    let a: Int? = nil
    let b: Int? = 2
    if let c=a ?? b { //类似于 if a != nil || b != nil
        print(c)
    }

    //** 隐式解包 **
    /*
     1、在某些情况下，可选项一但被设定值之后，就会一直拥有值
     2、在这种情况下，可以去掉检查，也不必每次访问的时候都进行解包，因为它能确定每次访问的时候都有值
     3、可以在类型后面加个感叹号！定义一个隐式解包的可选项
     */
    let num1: Int! = 10
    let num2: Int = num1
    if num2 != nil {
        print(num2 + 6)
    }
    if let num3 = num1 {
        print(num3)
    }

    //** 字符串插值 **
    //可选项在字符串插值或者直接打印时，编译器会发出警告
    //3种方法消除警告
    let age2: Int?=10
    print("My age is \(age2!)")
    print("My age is \(String(describing: age2))")
    print("My age is \(age2 ?? 0)")

    //** 多重可选项 **
    var num11: Int? = 10
    var num22: Int?? = num11
    var num33: Int?? = 10

    login1(["username" : "张三", "password" : "123456"])
    login1(["username" : "李四"])
    login1(["password" : "78900"])

    login2(["username" : "张三", "password" : "123456"])
    login2(["username" : "李四"])
    login2(["password" : "78900"])
}


