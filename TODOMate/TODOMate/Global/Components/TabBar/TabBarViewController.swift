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
            createViewController(for: HomeViewController(), title: "피드", imageName: .reIconFeed),
            createViewController(for: HomeViewController(), title: "둘러보기", imageName: .reIconExplore),
            createViewController(for: HomeViewController(), title: "알림", imageName: .reIconNoti),
            createViewController(for: HomeViewController(), title: "My", imageName: .reIconMy)
        ]
    }

    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = .lightGray
        itemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.cap_medi_10
        ]

        itemAppearance.selected.iconColor = .black
        itemAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.cap_semi_10
        ]
        appearance.stackedLayoutAppearance = itemAppearance

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }

    private func createViewController(for rootViewController: UIViewController,
                                      title: String,
                                      imageName: UIImage) -> UIViewController {
        let viewController = UINavigationController(rootViewController: rootViewController)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = imageName
        return viewController
    }
}
