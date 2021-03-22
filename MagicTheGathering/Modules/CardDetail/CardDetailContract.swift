//
//  CardDetailContract.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 22/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol CardDetailEntityContract: BaseEntity {
    
}

protocol CardDetailViewContract: BaseViewController {
    var presenter: CardDetailPresenterContract! { get set }
    
}

protocol CardDetailPresenterContract: BasePresenter {
    var view: CardDetailViewContract! { get set }
    var interactor: CardDetailInteractorContract! { get set }
    var entity: CardDetailEntityContract! { get set }
    var wireframe: CardDetailWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
}

protocol CardDetailInteractorContract: BaseInteractor {
    var output: CardDetailInteractorOutputContract! {get set}
}

protocol CardDetailInteractorOutputContract: class {
    
}

protocol CardDetailWireframeContract: BaseWireframe {
    var output: CardDetailWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
    
    func showBasicLoading(text: String)
    func hideBasicLoading(completion: @escaping (() -> Void))
}

protocol CardDetailWireframeOutputContract: class {

}
