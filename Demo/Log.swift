//
//  Log.swift
//  Demo
//
//  Created by ChenDong on 2018/12/6.
//

import Foundation

extension NSObject {
    
    func log(_ items: Any...) {
        print(NSStringFromClass(type(of: self)) + ": ", separator: "", terminator: "")
        print(items.map({ "\($0)" }).joined(separator: ""))
    }
}
