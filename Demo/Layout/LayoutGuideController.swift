//
//  LayoutGuideController.swift
//  Demo
//
//  Created by ChenDong on margin18/12/6.
//

import UIKit
import SnapKit

class LayoutGuideController: ViewController {
    
    private let redView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(redView)
        redView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(margin)
            make.left.equalToSuperview().offset(margin)
            make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-margin)
            make.right.equalToSuperview().offset(-margin)
        }
    }
}

class LayoutGuideWithTabBarController: LayoutGuideController { }

class LayoutGuideWithoutTabBarController: LayoutGuideController {
    required init() {
        super.init()
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
