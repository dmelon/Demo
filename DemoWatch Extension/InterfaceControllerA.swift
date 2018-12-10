//
//  InterfaceController.swift
//  DemoWatch Extension
//
//  Created by ChenDong on 2018/12/6.
//

import WatchKit
import Foundation


class InterfaceControllerA: WKInterfaceController {

    @IBOutlet var toB1Button: WKInterfaceButton!
    @IBOutlet var toB2Button: WKInterfaceButton!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func toB1Page() {
        run(navigation: .presentB1B2)
    }
    
    @IBAction func toB2Page() {
        run(navigation: .presentB2)
    }
    
    private func run(navigation: NavigationOption) {
        switch navigation {
        case .presentB1B2:
            // 可以工作
            presentController(withNames:
                ["InterfaceControllerB1",
                 "InterfaceControllerB2"], contexts: nil)
        case .presentB2:
            // 可以工作
            presentController(withName: "InterfaceControllerB2", context: nil)
        case .pushB1:
            // 不能工作
            pushController(withName: "InterfaceControllerB1", context: nil)
        }
    }
}

extension InterfaceControllerA {
    // https://developer.apple.com/library/archive/documentation/General/Conceptual/WatchKitProgrammingGuide/InterfaceStyles.html#//apple_ref/doc/uid/TP40014969-CH12-SW1
    // 主要是为了测试可能的 navigation
    enum NavigationOption {
        // present 多个 page-based controllers
        case presentB1B2
        // present 单个 controller
        case presentB2
        // 从 page-based 的 controllers 上 push 新的 controller
        case pushB1
    }
}
