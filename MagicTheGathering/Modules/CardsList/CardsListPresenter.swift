//
//  CardsListPresenter.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 21/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class CardsListPresenter: BasePresenter, CardsListPresenterContract {

    weak var view: CardsListViewContract!
    var interactor: CardsListInteractorContract!
    var entity: CardsListEntityContract!
    var wireframe: CardsListWireframeContract!

    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
}

// MARK: - CardsListInteractorOutputContract
extension CardsListPresenter: CardsListInteractorOutputContract {
    
}

// MARK: - CardsListWireframeOutputContract
extension CardsListPresenter: CardsListWireframeOutputContract {
    
}
