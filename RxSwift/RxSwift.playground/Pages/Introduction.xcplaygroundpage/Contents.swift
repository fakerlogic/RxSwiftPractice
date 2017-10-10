//: [Previous](@previous)

import Foundation

example(of: "Synchronous code") {
    var array = [1, 2, 3]
    for number in array {
        print(number)
        array = [4, 5, 6]
        print(array)
    }
    print(array)
}

/*:
 > `for` 循环会拷贝一份 `array`, 所以当在循环体中重新赋值 `array` 的时候, `array` 已经发生了变化,
 > 但是不会影响到 `for` 循环
 */



//: [Next](@next)
