//
//  Car.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/3/3.
//

import Foundation

/*
 OC调用Swift
 1、Swift暴露给OC的类最终继承自NSObject
 2、使用 @objc 修饰需要暴露给OC的成员
 3、使用 @objcMembers 修饰类
    a、代表默认所有成员都会暴露给OC（包括扩展中定义的成员）
    b、最终是否成功暴露，还需要考虑成员自身的访问级别
 注：
 1、Xcode会根据Swift代码生成对应的OC声明，写入{targetName}-Swift.h
 2、可以通过 @objc 重命名Swift暴露给OC的符号名（类名、属性、函数名等）
 */
@objcMembers class FFCar: NSObject {
    var price: Double
    var band: String
    init(price: Double, band: String) {
        self.price = price
        self.band = band
    }
    //实例方法
    func run() {
        print(price, band, "run")
    }
    //类方法
    static func run() {
        print("Car run")
    }
}

