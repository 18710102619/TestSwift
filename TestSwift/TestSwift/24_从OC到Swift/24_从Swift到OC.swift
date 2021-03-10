//
//  字符串_String.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/3/3.
//

import Foundation

/*
 1、String

 Swift的字符串类型String，跟OC的NSString，在API设计上还是有较大差异

 BidirectionalCollection 协议包含的部分内容
 1、startIndex、endIndex属性、index 方法
 2、String、Array 都遵守了这个协议

 RanageReplaceableCollection 协议包含的部分内容
 1、append、insert、remove 方法
 2、String、Array 都遵守了这个协议

 Dictionary、Set也有实现上述协议中声明的一些方法，只是并没有遵守上述协议
 */
func testString() {
    //空字符串
    let emptyStr1 = ""
    let emptyStr2 = String()

    var str : String = "1"
    //拼接
    str.append("_2")
    //重载运算符 +
    str = str + "_3"
    //重载运算符 +=
    str += "_4"
    //插入 \(
    str = "\(str)_5"
    //长度
    print(str.count)

    let str2 = "1234567890"
    print(str2.hasPrefix("123")) //true 前缀
    print(str2.hasSuffix("890")) //true 后缀

    //插入
    var str3 = "1_2"
    str3.insert("_", at: str3.endIndex)
    str3.insert(contentsOf: "3_4", at: str3.endIndex)
    str3.insert(contentsOf: "666", at: str3.index(after: str.startIndex))
    str3.insert(contentsOf: "888", at: str3.index(after: str.endIndex))
    str3.insert(contentsOf: "hello", at: str3.index(str3.startIndex, offsetBy: 4))

    //删除
    var str4 = "1234567890"
    str4.remove(at: str4.firstIndex(of: "1")!) //移除1
    str4.removeAll { $0 == "6"} //移除6
    var range = str4.index(str4.endIndex, offsetBy: -4)..<str4.index(after: str4.endIndex)
    str4.removeSubrange(range)
}

/*
 2、Substring

 String可以通过下标、prefix、suffix等截取子串，子串类型不是String，而是SubString
 1、Substring和它的base，共享字符串数据
 2、Substring发生修改 或者 转为String时，会分配新的内存存储字符串数据
 */
func testSubstring() {
    let str = "1_2_3_4_5"
    // 1_2
    let sub1 = str.prefix(3)
    // 4_5
    let sub2 = str.suffix(3)
    // 1_2
    var range = str.startIndex..<str.index(str.startIndex, offsetBy: 3)
    var substr3 = str[range]

    //最初的String，1_2_3_4_5
    print(substr3.base)
    //Substring -> String
    var str2 = String(substr3)
}

/*
 3、Character

 c是Character类型
 */
func testCharacter() {
    let str = "1_2_3_4_5"
    for c in "jack" {
        print(c)
    }
    var c=str[str.startIndex]
}

/*
 4、String与NSString

 String与NSString之间可以随时地桥接转换
 如果你觉得String的API过于复杂难用，可以考虑String转为NSString

 比较字符串内容是否等价
 1、String使用 == 运算符
 2、NSString使用isEqual方法，也可以使用 == 运算符（本质还是调用了 isEqual 方法）
 */
func testString_NSString() {
    var str1: String = "jack"
    var str2: NSString = "rose"

    var str3 = str1 as NSString
    var str4 = str1 as String

    var str5 = str3.substring(with: NSRange(location: 0, length: 2))
}

/*
 5、只能被class继承的协议

 被 @objc 修饰的协议，还可以暴露给OC去遵守实现
 */
protocol Runnable24_1: AnyObject { }
protocol Runnable24_2: class { }
@objc protocol Runnable24_3 {}

/*
 6、可选协议

 可以通过 @objc 定义可选协议，这种协议只能被 class 遵守
 */
@objc protocol Runnable24 {
    func run1()
    @objc optional func run2()
    func run3()
}
class Dog24_1: Runnable24 {
    func run1() {
        print("Dog run1")
    }
    func run3() {
        print("Dog run3")
    }
}

/*
 7、dynamic

 被@objc dynamic修饰的内容会具有动态性，比如调用方法会走runtime那一套流程
 */
class Dog24_2: Runnable24 {
    @objc dynamic func run1() {
        print("Dog run1")
    }
    func run3() {
        print("Dog run3")
    }
}

/*
 8、KVC\KVO

 Swift支持 KVC\KVO 的条件
 属性所在的类、监听器最终继承自NSObject
 用 @objc dynamic 修饰对应的属性
 */
class Observer: NSObject {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("observeValue：", change?[.newKey] as Any)
    }
}
class Person24_1: NSObject {
    @objc dynamic var age: Int = 0
    var observer: Observer = Observer()
    override init() {
        super.init()
        self.addObserver(observer,
                         forKeyPath: "age",
                         options: .new,
                         context: nil)
    }
    deinit {
        self.removeObserver(observer, forKeyPath: "age")
    }
}
//block方式的KVO
class Person24_2: NSObject {
    @objc dynamic var age: Int = 0
    var observer: NSKeyValueObservation?
    override init() {
        super.init()
        observer = observe(\Person24_2.age, options: .new) {
            (person, change) in
            print(change.newValue as Any)
        }
    }
}

/*
 9、关联对象

 在Swift中，class依然可以使用关联对象
 默认情况，extension不可以增加存储属性
 借助关联对象，可以实现类似extension为class增加存储属性效果
 */
class Person24_3 { }
extension Person24_3 {
    private static var AGE_KEY: Void?
    var age: Int {
        get {
            (objc_getAssociatedObject(self, &Self.AGE_KEY) as? Int) ?? 0
        }
        set {
            objc_setAssociatedObject(self, &Self.AGE_KEY, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

/*
 10、资源名管理
 */
enum R {
    enum string: String {
        case add = "添加"
    }
    enum image: String {
        case logo
    }
    enum segue: String {
        case login_main
    }
}

func testSwift_OC() {

    //8、KVC\KVO
    let p1 = Person24_1()
    p1.age = 10
    p1.setValue(25, forKey: "age")

    let p2 = Person24_2()
    p2.age = 20
    p2.setValue(25, forKey: "age")
}
