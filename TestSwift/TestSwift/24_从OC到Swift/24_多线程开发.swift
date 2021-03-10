//
//  多线程开发.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/3/10.
//
//  多线程开发

import Foundation

public typealias Task = () -> Void

/*
 1、多线程开发 - 异步
 */
public func async(_ task: @escaping Task) {
    _async(task)
}
public func async(_ task: @escaping Task,
                  _ mainTask: @escaping Task) {
    _async(task, mainTask)
}
private func _async(_ task: @escaping Task,
                           _ mainTask: Task? = nil) {
    let item = DispatchWorkItem(block: task)
    DispatchQueue.global().async(execute: item)
    if let main = mainTask {
        item.notify(queue: DispatchQueue.main, execute: main)
    }
}

/*
 2、多线程开发 - 延迟
 */
@discardableResult
public func delay(_ seconds: Double,
                  _ block: @escaping Task) -> DispatchWorkItem {
    let item = DispatchWorkItem(block: block)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds,
                                  execute: item)
    return item
}

/*
 3、多线程开发 - 异步延迟
 */
@discardableResult
public func asyncDelay(_ seconds: Double,
                       _ task: @escaping Task) -> DispatchWorkItem {
    return _asyncDelay(seconds, task)
}
public func asyncDelay(_ seconds: Double,
                       _ task: @escaping Task,
                       _ mainTask: @escaping Task) -> DispatchWorkItem {
    return _asyncDelay(seconds, task, mainTask)
}
private func _asyncDelay(_ seconds: Double,
                         _ task: @escaping Task,
                         _ mainTask: Task? = nil) -> DispatchWorkItem {
    let item = DispatchWorkItem(block: task)
    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds,
                                      execute: item)
    if let main = mainTask {
        item.notify(queue: DispatchQueue.main, execute: main)
    }
    return item
}

/*
 4、多线程开发 - once
 dispatch_once在Swift中已被废弃，取而代之
 可以用类型属性或者全局变量\常量
 默认自带 lazy + dispatch_once 效果
 */
fileprivate let initTask2: Void = {
    print("initTask2-------------")
}()

/*
 5、多线程开发 - 加锁
 */
class Cache {
    private static var data = [String: Any]()
    private static var lock = DispatchSemaphore(value: 1)
    static func set(_ key: String, _ value: Any) {
        lock.wait()
        defer {
            lock.signal()
        }
        data[key] = value
    }
}

func testThread() {
    
}
