//
//  Demo0.swift
//  Demo0
//
//  Created by ChenDong on 2018/12/17.
//

import Foundation

struct Demo0 {
    
    static func add() -> Int {
        return 1 + 2
    }
    
    static func add2() -> Int {
        return 3 + 4
    }
    
    static func perform(function: () -> Int) -> Int {
        return function()
    }
    
    static func run() {
        var ret = perform(function: add)
        print("demo0: perform function add: \(ret)")
        
        ret = perform(function: add2)
        print("demo0: perform function add2: \(ret)")
    }
}

struct Demo1 {
    
    let value: Int
    
    func adding(b: Int) -> Int {
        return value + b
    }
    
    static func run() {
        let instance = Demo1(value: 3)
        let c = instance.adding(b: 4)
        print("demo1: perform function adding: \(c)")
    }
}

