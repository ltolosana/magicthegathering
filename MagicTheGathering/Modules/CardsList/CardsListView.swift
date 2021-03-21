//
//  CardsListView.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 21/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class CardsListView: BaseViewController, CardsListViewContract {

	var presenter: CardsListPresenterContract!

	// MARK: - LifeCycle
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

    }
}
