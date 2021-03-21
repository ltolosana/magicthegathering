//
//  CardsListContract.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 21/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol CardsListEntityContract: BaseEntity {
    
}

protocol CardsListViewContract: BaseViewController {
    var presenter: CardsListPresenterContract! { get set }
    
}

protocol CardsListPresenterContract: BasePresenter {
    var view: CardsListViewContract! { get set }
    var interactor: CardsListInteractorContract! { get set }
    var entity: CardsListEntityContract! { get set }
    var wireframe: CardsListWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
}

protocol CardsListInteractorContract: BaseInteractor {
    var output: CardsListInteractorOutputContract! {get set}
}

protocol CardsListInteractorOutputContract: class {
    
}

protocol CardsListWireframeContract: BaseWireframe {
    var output: CardsListWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
    
    func showBasicLoading(text: String)
    func hideBasicLoading(completion: @escaping (() -> Void))
}

protocol CardsListWireframeOutputContract: class {

}
