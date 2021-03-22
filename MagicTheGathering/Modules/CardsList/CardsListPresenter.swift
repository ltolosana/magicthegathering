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
        
        setUpNavigationTitle()
        
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
    
    func selectCardItem(index: Int) {
        if cardsList.count > index {
            let card = cardsList[index]
            wireframe.showDetailCardView(card: card)
        } else {
            wireframe.showCustomModalAlert(view,
                                           title: "Card not found",
                                           content: "Selected card not found\nPlease select another card.",
                                           completion: nil)
        }
    }
    
    private func setUpNavigationTitle() {
        if let magicFontTitle = UIFont(name: "MagicMedieval", size: 24) {
            let attributes = [NSAttributedString.Key.font: magicFontTitle]
            view.navigationController?.navigationBar.titleTextAttributes = attributes
        }
        
        view.title = "Magic Cards List"
    }
}

// MARK: - CardsListInteractorOutputContract
extension CardsListPresenter: CardsListInteractorOutputContract {
    
}

// MARK: - CardsListWireframeOutputContract
extension CardsListPresenter: CardsListWireframeOutputContract {
    
}
