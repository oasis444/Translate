//
//  ViewController.swift
//  Translate
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let translateVC = TranslateVC()
        translateVC.tabBarItem = UITabBarItem(
            title: "번역",
            image: UIImage(systemName: "mic"),
            selectedImage: UIImage(systemName: "mic.fill")
        )
        
        let bookMarkVC = UINavigationController(rootViewController: BookmarkListVC())
        bookMarkVC.tabBarItem = UITabBarItem(
            title: "즐겨찾기",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
        
        viewControllers = [translateVC, bookMarkVC]
        tabBar.tintColor = UIColor.mainTintColor
    }
}

