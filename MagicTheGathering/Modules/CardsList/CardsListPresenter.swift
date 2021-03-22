//
//  CardsListPresenter.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 21/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

class CardsListPresenter: BasePresenter, CardsListPresenterContract {

    weak var view: CardsListViewContract!
    var interactor: CardsListInteractorContract!
    var entity: CardsListEntityContract!
    var wireframe: CardsListWireframeContract!

    var cardsList: [Card] = []
    
    func viewDidLoad() {

        firstly {
            interactor.getCardsList()
        }.done { [weak self] cardsListData in
            self?.cardsList = cardsListData
            self?.view.updateCardsData(cards: cardsListData)
        }.catch { error in
            self.wireframe.feedbackError(error: error)
        }
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
