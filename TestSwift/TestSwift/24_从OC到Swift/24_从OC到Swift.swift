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
