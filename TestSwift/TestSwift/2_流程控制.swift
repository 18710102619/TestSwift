//
//  2_流程控制.swift
//  TestSwift
//
//  Created by 张玲玉 on 2021/1/27.
//

import Foundation

//1.if-else
/*
 1、if后面的条件可以省略小括号
 2、条件后面的大括号不可以省略
 3、if后面的条件只能是Bool类型
 */
func testIf(_ age: Int) {
    if age >= 20 {
        print("大于等于20")
    } else {
        print("小于20")
    }
}

//2.while
/*
 1、repeat-while相当于C语言中的do-while
 2、这里不用num--，是因为从Swift3开始，去除了自增（++）、自减（--）运算符
*/
func testWhile() {
    var num=5
    while num>0 {
        print("num is \(num)")
        num = num - 1
    }
    repeat { //至少执行一次
        print("num is \(num)")
    } while num > 0
}

//3.for
func testFor() {
    let names = ["A","B","C","D"]
    //1、闭区间运算符：a...b，a<= 取值 <= b
    for i in 0...3 {
        print(names[i])
    }
    let range = 1...3
    for i in range {
        print(names[i])
    }
    //i默认是let，有需要时可以声明为var
    for var i in 1...3 {
        i+=5
        print(i) //6 7 8
    }
    //2、半开区间运算符：a..<b，a<=取值 < b
    for i in 1..<5 {
        print(i) //1 2 3 4
    }
    //3、单侧区间：让区间朝一个方向尽可能的远
    for name in names[0...3] {
        print(name)//A B C D
    }
    for name in names[2...] {
        print(name)//C D
    }

    //区间类型
    let range2 = ...5
    print(range2.contains(7)) //false
    print(range2.contains(4)) //true
    print(range2.contains(-3)) //true
}

//4.区间类型
func testRange() {
    let range:ClosedRange<Int> = 1...3
    print(range)
    //字符、字符串也能使用区间运算符，但默认不能用在for-in中
    //\0到~囊括了所有可能要用到的ASCII字符
    let charRange:ClosedRange<Character>="\0"..."~"
    print(charRange.contains("G"))//true
    //带间隔的区间值
    //i的取值：从4开始，累计2，不超过11
    for i in stride (from: 4, through: 11, by: 2) {
        print(i) //4 6 8 10
    }
}

//5.switch
/*
 1、switch必须要保证能处理所有情况
 2、case、default后面不能写大括号{}，后面至少要有一条语句
 3、默认可以不写break，并不会贯穿到后面的条件，如果不想做任何事，加个break即可
 4、使用fallthrough可以实现贯穿效果
 5、如果能保证已处理所有情况，也可以不必使用default
 */
func testSwitch(_ number: Int) {
    switch number {
    case 1:
        print(number) //执行
        fallthrough
    case 2:
        print(number) //执行
        break
    default:
        break
    }
    
    //由于已确定answer类型，因此可以省略Answer
    enum Answer {case right, wrong}
    let answer=Answer.right
    switch answer {
    case .right:
        print("right")
    case .wrong:
        print("wrong")
    }

    //**复合条件**
    //switch也支持String、Character类型
    let str:String = "Jack"
    switch str {
    case "Jack":
        fallthrough
    case "Rose":
        print("Right person")
    default:
        break
    }
    let char:Character = "a"
    switch char {
    case "a","A":
        print("Right person")
    default:
        break
    }

    //区间匹配、元组匹配
    let count = 0
    switch count {
    case 0:
        print(count)
    case 1..<5:
        print(count)
    case 5..<10:
        print(count)
    default:
        break
    }
    //可以使用下划线_忽略某个值
    //关于case匹配问题，属于模式匹配的范畴
    let point = (0,0)
    switch point {
    case (0,0):
        print(point)
    case (_,0):
        print(point)
    case (-2...2,-2...2):
        print(point)
    default:
        break
    }

    //**值绑定**
    switch point {
    case (var x,0):
        x += 2
    case (0,var y):
        y += 2
    case var (x,y):
        x += 2
        y += 2
    }
}

//6.where
func testWhere(_ point:(Int,Int)) {
    switch point {
    case var(x, y) where x == y:
        x += 2
    case var(x, y) where x == -y:
        y += 2
    case var(x, y):
        x += 2
        y += 2
    }
    //将所有正数加起来
    var numbers = [10,20,30,40,-10,-20]
    var sum=0
    let num=0
    for item in numbers where num > 0{
        sum += num
    }
}

//7.标签语句
func testOuter() {
    outer: for i in 1...4 {
        for k in 1...4 {
            if k==3 {
                continue outer
            }
            if i==3 {
                break outer
            }
            print("i==\(i),k==\(k)")
        }
    }
}

//测试用例
func testControl() {
    //7
    testOuter()
    //6
    testWhile()
    //5
    testSwitch(1)
    //4
    testRange()
    //3
    testFor()
    //2
    testWhile()
    //1
    testIf(10)
}
