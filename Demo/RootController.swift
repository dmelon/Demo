//
//  RootController.swift
//  Demo
//
//  Created by ChenDong on 2018/12/6.
//

import UIKit

class RootController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewControllers = [
            layout(),
            settings()
        ]
    }
    
    func layout() -> NavigationController {
        let nv = NavigationController()
        let vc = LayoutOptionsController()
        nv.pushViewController(vc, animated: false)
        nv.tabBarItem = UITabBarItem(title: "Layout", image: nil, tag: 0)
        return nv
    }
    
    func settings() -> NavigationController {
        let nv = NavigationController()
        let vc = SettingsOptionsController()
        nv.pushViewController(vc, animated: false)
        nv.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 0)
        return nv
    }
}

