//
//  RootController.swift
//  Demo
//
//  Created by ChenDong on 2018/12/6.
//

import UIKit
import RxSwift
import RxCocoa

class RootController: UITabBarController {

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewControllers = [
            layout,
            settings,
        ]
        
        weak var welf = self
        SettingsStore
            .tabBarIsTranslucentRelay
            .subscribe(onNext: { (value) in
                guard let `self` = welf else { return }
                self.tabBar.isTranslucent = value
            })
            .disposed(by: bag)
    }

    // layout tab
    private let layout: NavigationController = {
        let nv = NavigationController()
        
        var request = NSBundleResourceRequest(tags: ["Install"])
        request.conditionallyBeginAccessingResources(completionHandler: { (downloaded) in
            print("install is downloaded \(downloaded)")
            request.beginAccessingResources(completionHandler: { (error) in
                //
                print("install fetch error \(error)")
            })
        })
        
//        request = NSBundleResourceRequest(tags: ["Launch"])
//        request.conditionallyBeginAccessingResources(completionHandler: { (downloaded) in
//            print("launch is downloaded \(downloaded)")
//            request.beginAccessingResources(completionHandler: { (error) in
//                //
//                print("launch fetch error \(error)")
//            })
//        })
        
        nv.tabBarItem = UITabBarItem(title: "Layout", image: UIImage(named: "layout"), tag: 0)
        
        let vc = LayoutOptionsController()
        nv.pushViewController(vc, animated: false)
        return nv
    }()
    
    // settings tab
    private let settings: NavigationController = {
        let nv = NavigationController()
        nv.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 1)
        
        let vc = SettingsOptionsController()
        nv.pushViewController(vc, animated: false)
        return nv
    }()
}

