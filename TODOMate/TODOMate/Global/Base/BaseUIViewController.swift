//
//  BaseUIViewController.swift
//  TODOMate
//
//  Created by 성현주 on 5/8/25.
//

import UIKit

class BaseUIViewController: UIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true

        setUI()
        setLayout()
        addTarget()
        setDelegate()

    }

    // MARK: - Custom Method

    func setUI() {}

    func setLayout() {}

    // MARK: - Action Method

    func addTarget() {}

    // MARK: - delegate Method

    func setDelegate() {}
}
