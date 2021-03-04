//
//  24_从OC到Swift.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/3/2.
//

import Foundation

/*
 MARK、TODO、FIXME
 1、MARK: 类似于OC中的 #pragma mark
 2、MARK: - 类似于OC中的 #pragma mark -
 3、TODO: 用于标记未完成的任务
 4、FIXME: 用于标记待修复的问题
 */
func test24_1() {
    // TODO: 未完成
}
func test24_2() {
    // FIXME: 待修复
}
public class Person24 {
    // MARK: - 属性
    var age = 0
    var weight = 0
    var height = 0

    // MARK: - 私有方法
    // MARK: 跑步
    private func run1() {}
    private func run2() {}
    // MARK: 走路
    private func walk1() {}
    private func walk2() {}

    // MARK: - 公共方法
    private func eat1() {}
    private func eat2() {}
}

/*
 条件编译
 */
//操作系统：macOS\iOS\tvOS\watchOS\Linux\Android\Windroid\Window\FreeBSD
#if os(maxOS) || os(iOS)
//CPU架构：i386\x86_64\arm\arm64
#elseif arch(x86_64) || arch(arm64)
//swift版本
#elseif swift(<5) && swift(>=3)
//模拟器
#elseif targetEnvironment(simulator)
//可以导入某模块
#elseif canImport(Foundation)
#else
#endif

/*
 条件编译
 */
#if DEBUG
//debug模式
#else
//release模式
#endif

/*
 打印
 */
func log<T>(_ msg: T,
            file: NSString = #file,
            line: Int = #line,
            fn: String = #function)  {
    #if DEBUG
    let prefix = "\(file.lastPathComponent)_\(line)_\(fn):"
    print(prefix,msg)
    #endif
}

/*
 系统版本检测
 */
func test24_3() {
    if #available(iOS 10, macOS 10.12, *) {
        //对于iOS平台，只在iOS10及以上版本执行
        //对于macOS平台，只在macOS 10.12及以上版本执行
        //最后的*表示在其他所有平台都执行
    }
}

/*
 API可用性说明
 */
func test24_4() {
    @available(iOS 10, macOS 10.15, *)
    class Person {}

    struct Student {
        @available(*, unavailable, renamed: "study")
        func study_() {}
        func study() {}

        @available(iOS, deprecated: 11)
        @available(macOS, deprecated: 10.12)
        func run() {}
    }
}

/*
 iOS程序的入口
 在AppDelegate上面默认有个@UIApplicationMain标记，这表示
 编译器自动生成入口代码（main函数代码），自动设置Appdelegate为APP的代理
 注：也可以删掉@UIApplicationMain，自定义入口代码：新建一个main.swift文件
 */

/*
 Swift调用OC
 新建1个桥接头文件，文件名格式默认为：{targetName}-Bridging-Header.h
 在 {targetName}-Bridging-Header.h 文件中 #import OC需要暴露给Swift的内容

 如果C语言暴露给Swift的函数名跟Swift中的其他函数名冲突了
 可以在Swift中使用 _silgen_name 修改C函数名
 */
@_silgen_name("sum") func swift_sum(_ v1: Int32, _ v2: Int32) -> Int32
func testOCSwift() {

    let p = FFPerson(age: 10, name: "Jack")
    p.age=10
    p.name="Rose"
    p.run()
    p.eat("Apple", other: "Water")

    FFPerson.run()
    FFPerson.eat("Pizza", other: "Banana")

    print(swift_sum(10, 20))
    print(sum(10, 20))
}

