//
//  String.swift
//  Demo
//
//  Created by ChenDong on 2018/12/6.
//

import Foundation

extension String {
    
    // "ThisIsAString" -> "This Is A String"
    var splitedCamelString: String {
        
        return self.map({ String($0) })
            .splitBefore(separator: { $0.uppercased() == $0 })
            .map({ $0.joined() })
            .joined(separator: " ")
    }
}
