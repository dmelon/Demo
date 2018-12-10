//
//  InterfaceControllerB.swift
//  DemoWatch Extension
//
//  Created by ChenDong on 2018/12/7.
//

import WatchKit
import Foundation

class InterfaceControllerC: WKInterfaceController {
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        NotificationCenter.default.addObserver(self, selector: #selector(on(notification:)), name: Notification.Name("InterfaceControllerC_becomeCurrentPage"), object: nil)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @objc func on(notification: Notification) {
        becomeCurrentPage()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
