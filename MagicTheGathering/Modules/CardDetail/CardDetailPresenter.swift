//
//  CardDetailPresenter.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 22/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class CardDetailPresenter: BasePresenter, CardDetailPresenterContract {

    weak var view: CardDetailViewContract!
    var interactor: CardDetailInteractorContract!
    var entity: CardDetailEntityContract!
    var wireframe: CardDetailWireframeContract!

    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
}


// MARK: - CardDetailInteractorOutputContract
extension CardDetailPresenter: CardDetailInteractorOutputContract {
    
}

// MARK: - CardDetailWireframeOutputContract
extension CardDetailPresenter: CardDetailWireframeOutputContract {
    
}
