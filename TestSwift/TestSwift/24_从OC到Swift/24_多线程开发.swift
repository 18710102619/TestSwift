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
 多线程开发
 */
public struct Asyncs {
    //1、异步
    public static func async(_ task: @escaping Task) {
        _async(task)
    }
    public static func async(_ task: @escaping Task,
                             _ mainTask: @escaping Task) {
        _async(task, mainTask)
    }
    private static func _async(_ task: @escaping Task,
                               _ mainTask: Task? = nil) {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }

    //2、延迟
    @discardableResult
    public static func delay(_ seconds: Double,
                             _ block: @escaping Task) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds,
                                      execute: item)
        return item
    }

    //3、异步延迟
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ task: @escaping Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task)
    }

    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ task: @escaping Task,
                                  _ mainTask: @escaping Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task, mainTask)
    }

    private static func _asyncDelay(_ seconds: Double,
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
}

/*
 加锁
 */
public struct Cache {
    private static var data = [String: Any]()
    //    private static var lock = DispatchSemaphore(value: 1)
    //    private static var lock = NSLock()
    private static var lock = NSRecursiveLock()

    public static func get(_ key: String) -> Any? {
        data[key]
    }

    public static func set(_ key: String, _ value: Any) {
        //        lock.wait()
        //        defer { lock.signal() }

        lock.lock()
        defer { lock.unlock() }

        data[key] = value
    }
}

/*
 Once
 dispatch_once 在Swift中已被废弃，取而代之
 可以用类型属性或者全局变量\常量
 默认自带 lazy + dispatch_once 效果
 */
class Dog24 {
    static var age: Int = {
        print("age")
        return 0
    }()

    init() {
        print(Self.age)
        print(Self.age)
        print(Self.age)
    }
}

func testThread() {

    let dog = Dog24()

    Asyncs.asyncDelay(1.0, {
        //延迟执行的方法
        print("1111111")
    }) {
        print("2222222")
    }
}
