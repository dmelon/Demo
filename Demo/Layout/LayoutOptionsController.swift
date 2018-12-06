//
//  LayoutOptionsController.swift
//  Demo
//
//  Created by ChenDong on 2018/12/6.
//

import UIKit

class LayoutOptionsController: OptionsController {
    
    override init() {
        super.init()
        title = "Layout"
        items = [
            push(SafeAreaWithTabBarController.self),
            push(SafeAreaWithoutTabBarController.self),
            push(LayoutGuideWithTabBarController.self),
            push(LayoutGuideWithoutTabBarController.self),
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let margin: CGFloat = 20
