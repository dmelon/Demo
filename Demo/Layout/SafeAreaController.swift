//
//  SafeAreaController.swift
//  Demo
//
//  Created by ChenDong on margin18/12/6.
//

import UIKit
import SnapKit

class SafeAreaController: ViewController {
    
    private let redView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(redView)
        redView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(margin)
                make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(margin)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-margin)
                make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-margin)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            log("status bar height: \(UIApplication.shared.statusBarFrame.height)")
            log("navigation bar height: \(navigationController!.navigationBar.bounds.height)")
            log("tab bar height: \(tabBarController!.tabBar.bounds.height)")
            log("safe area layout guide: \(view.safeAreaLayoutGuide)")
        } else {
            // Fallback on earlier versions
        }
    }
}

class SafeAreaWithTabBarController: SafeAreaController { }

class SafeAreaWithoutTabBarController: SafeAreaController {
    required init() {
        super.init()
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

