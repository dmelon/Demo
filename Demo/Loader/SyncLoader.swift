//
//  SyncLoader.swift
//  Demo
//
//  Created by ChenDong on 2018/12/13.
//

import Foundation
import Result

protocol AsyncGetterType {
    associatedtype Value
    func load(_ completion: @escaping (Value) -> Void)
}

extension AsyncGetterType {
    
    func syncLoad() -> Value {
        let n: Int = 0
        let semaphore = DispatchSemaphore(value: 0)
        var result: Value!
        load { (ret) in
            result = ret
            semaphore.signal()
        }
        semaphore.wait()
        return result
    }
}


/*
 1. 实例方法其实也是 block
 2. value 和 block 可以相互转化
 比如，Int 的实例方法 `public func distance(to other: Int) -> Int`
 可以转化为一个 global 闭包
 `func distance(between first: Int, second: Int) -> Int`
 a.(b), (a, b), b.(a)
 既然这么写，那么实例方法又有什么用呢？
 
 
 1. 如果一个实例内部都是不可变的 value，那么这个类型的实例方法都可以改写为外部的 global block，也可以改写成任何一个参与 value 的实例变量
 */

/*
 
 */
struct IntValue {
    let value: Int
    let connector = true
    func append(string: String) -> String {
        return "\(value)" + string
    }
}

struct Bytes: RawRepresentable {
    let rawValue: Int64
    init(rawValue: Int64) {
        self.rawValue = rawValue
        let cids: Set<Int> = []
        
    }
}


extension Bytes {
    var sizeString: String {
        
        var size = rawValue
        
        let xB = size % 1024
        size /= 1024
        
        let xKB = size % 1024
        size /= 1024
        
        let xMB = size
        
        var sizeText = "0B"
        
        if xMB > 0 {
            sizeText = "\(xMB) MB"
        } else if xKB > 0 {
            sizeText = "\(xKB) KB"
        } else if xB > 0 {
            sizeText = "\(xB) B"
        }
        
        return sizeText
    }
}
