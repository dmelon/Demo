//
//  main.swift
//  Encoding
//
//  Created by 陈东 on 2019/8/7.
//  Copyright © 2019 陈东. All rights reserved.
//

import Foundation

extension UInt16 {
    var bytes: [UInt8] {
        return [self & 0xff, (self >> 8) & 0xff].map({ UInt8($0) })
    }
}

extension UInt32 {
    var bytes: [UInt8] {
        return [
            self & 0xff, (self >> 8) & 0xff,
            (self >> 16) & 0xff, (self >> 24) & 0xff,
            ].map({ UInt8($0) })
    }
}

var str = "abc123知乎者也✔️🇵🇷é"
str = "知乎者也é"

func printHex(for str: String, using encoding: String.Encoding) {

    let data = str.data(using: encoding)!
    var result = true
    
    switch encoding {
    case .utf8:
        result = Array(str.utf8) == Array(data)
        
    case .utf16LittleEndian:
        let bytes = str.utf16.flatMap({ $0.bytes })
        result = bytes == Array(data)

    case .utf32LittleEndian:
        let bytes = str.unicodeScalars.map({ $0.value }).flatMap({ $0.bytes })
        result = bytes == Array(data)
        
    default:
        break
    }
    print(data.map({ String(format: "%x", $0) }).joined())
    assert(result)
}

printHex(for: str, using: .utf8)
printHex(for: str, using: .utf16LittleEndian)
printHex(for: str, using: .utf32LittleEndian)



