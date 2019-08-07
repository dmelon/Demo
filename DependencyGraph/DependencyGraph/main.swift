//
//  main.swift
//  DependencyGraph
//
//  Created by 陈东 on 2019/7/16.
//  Copyright © 2019 陈东. All rights reserved.
//

import Foundation

class Base {
    
    func update() {
        _update();
    }
    
    private func _update() {
        print("base _update")
    }
}

class Sub: Base {
    private func _update() {
        print("sub _update")
    }
}

/*
 Unicode Scalar 有 21 bit，因此用 UInt32 表示
 */
let en = ["X", "Y", "Z"] // 0058, 0059, 005a
let cn = ["周", "杰", "伦"] // 53E4, 5468, 57fa
let emoji = "😂" // 1f602
let cluster = ["✔️", "🇵🇷", "é", "\u{65}\u{301}", "́"] // 2714, fe0f(VS16, variation selectors, https://unicode-table.com/en/FE0F/)

for letter in cluster {
    print("letter is \(letter)")
    for scalar in letter.unicodeScalars {
        print("Unicode scalar: \(scalar)" + ", hex value = 0x" + String(format: "%x", scalar.value))
    }
}

//let obj = Sub()
//obj.update()

let oc_obj = OCSub()
oc_obj.update()


//let encoding_study = EncodingStudy()

struct Entity {
    
    let value: Int
    
    var hex: String {
        return String(format: "%x", value)
    }
    var bin: String {
        return String(format: "%b", value)
    }
    
    init(_ v: Int) {
        value = v
    }
}

struct DoubleRelation {
    
    static var overall: [DoubleRelation] = []
    
    let one: Entity
    let two: Entity
    
    init(a: Int, b: Int) {
        one = Entity(a)
        two = Entity(b)
        DoubleRelation.overall.append(self)
    }
}
