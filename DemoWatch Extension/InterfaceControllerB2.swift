//
//  InterfaceControllerB.swift
//  DemoWatch Extension
//
//  Created by ChenDong on 2018/12/7.
//

import WatchKit
import Foundation

class InterfaceControllerB2: WKInterfaceController {
    
    @IBOutlet var toCButton: WKInterfaceButton!
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
    @IBAction func toCPage() {
        dismiss()
        NotificationCenter.default.post(name: Notification.Name("InterfaceControllerC_becomeCurrentPage"), object: nil)
    }
}
