//
//  TabBarViewController.swift
//  TODOMate
//
//  Created by 성현주 on 5/12/25.
//

import UIKit

final class TabBarViewController: UITabBarController {

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarAppearance()
    }

    // MARK: - Private Methods

    private func setupViewControllers() {
        viewControllers = [
            createViewController(for: ViewController(), title: "피드", imageName: "house.fill"),
            createViewController(for: ViewController(), title: "둘러보기", imageName: "location.north.circle"),
            createViewController(for: ViewController(), title: "알림", imageName: "bell"),
            createViewController(for: ViewController(), title: "My", imageName: "person")
        ]
    }

    //TODO: - 아이콘, 색상, 폰트 변경하기
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = .lightGray
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        itemAppearance.selected.iconColor = .black
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]

        appearance.stackedLayoutAppearance = itemAppearance

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }

    private func createViewController(for rootViewController: UIViewController,
                                      title: String,
                                      imageName: String) -> UIViewController {
        let viewController = UINavigationController(rootViewController: rootViewController)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(systemName: imageName)
        return viewController
    }
}
