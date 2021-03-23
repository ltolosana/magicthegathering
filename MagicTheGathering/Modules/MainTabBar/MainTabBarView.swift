//
//  MainTabBarView.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class MainTabBarView: BaseTabBarController, MainTabBarViewContract {

	var presenter: MainTabBarPresenterContract!

	// MARK: - LifeCycle
    
    override func loadView() {
        MainTabBarBuilder.setupPresenter(view: self)
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }

    private func setupView() {
        let views = presenter.getTabBarViewController()

        self.viewControllers = views
        self.selectedIndex = 0
    }
}
