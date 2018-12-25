//
//  Demo2.swift
//  Demo
//
//  Created by ChenDong on 2018/12/25.
//

import Foundation

class Demo2: NSObject {
    /// function 0
    func fun() {
        print("function 0")
    }
    
    /// function 0_
    func fun() -> Int {
        print("function 0_")
        return 0
    }
    
    /// function 1
    func fun(first: Int) {
        print("function 1")
    }
    
    /// function 2
    func fun(second: Int) {
        print("function 2")
    }
    
    /// function 2_
    func fun(second: Bool) {
        print("function 2_")
    }
    
    /// function 3
    func fun(_ third: Void) {
        print("function 3")
    }
    
    /// function 4
    @objc func ofun(fourth: Int) {
        print("function 4")
    }
    
    /// Error: Method 'ofun(fourth:)' with Objective-C selector 'ofunWithFourth:' conflicts with previous declaration with the same Objective-C selector
//    @objc func ofun(fourth: Bool) {
//        print("function 4")
//    }
    
    static func run() {
        
        let d = Demo2()
        
        let f0 = d.fun as () -> Void
        let f0_ = d.fun as () -> Int

        let f1 = d.fun(first:)
        
        let f2 = d.fun(second:) as (Int) -> Void
        let f2_ = d.fun(second:) as (Bool) -> Void
        let f2_1 = d.fun as (Bool) -> Void
        
        let f3 = d.fun(_:)
        let f31 = d.fun as (()) -> Void
        
//        var ff = f31
//        ff = f0

        f0() // 输出 function 0
        _ = f0_() // 输出 function 0_
        
        f1(0) // 输出 function 1
        
        f2(0) // 输出 function 2
        f2_(true) // 输出 function 2_
        f2_1(true) // 输出 function 2_

        f3(()) // 输出 function 3
        f31(()) // 输出 function 3
    }
    
    // TODO: 
    // https://github.com/apple/swift-evolution/blob/master/proposals/0022-objc-selectors.md
    // https://stackoverflow.com/questions/42048535/why-does-it-need-to-force-unwrap-the-selector-to-avoid-swift-ambiguous-reference
    static func run2() {
        typealias DownloadType = (URLSessionDataDelegate) -> (URLSession, URLSessionDataTask, URLSessionDownloadTask) -> Void
        typealias StreamType = (URLSessionDataDelegate) -> (URLSession, URLSessionDataTask, URLSessionDownloadTask) -> Void
        
        var sel = #selector(URLSessionDataDelegate.urlSession(_:dataTask:didBecome:)! as DownloadType)
        sel = #selector(URLSessionDataDelegate.urlSession(_:dataTask:didBecome:)! as StreamType)
        
        /// ?? 下面两个方法为什么不行
        // sel = #selector(Demo2.urlSession(_:dataTask:didBecome:)! as DownloadType)
        // sel = #selector(Demo2.urlSession(_:dataTask:didBecome:)! as StreamType)
    }
}


extension Demo2: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome downloadTask: URLSessionDownloadTask) {
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome streamTask: URLSessionStreamTask) {
        
    }
}
