//
//  NewPlayerFormContract.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol NewPlayerFormEntityContract: BaseEntity {
    
}

protocol NewPlayerFormViewContract: BaseViewController {
    var presenter: NewPlayerFormPresenterContract! { get set }
    
}

protocol NewPlayerFormPresenterContract: BasePresenter {
    var view: NewPlayerFormViewContract! { get set }
    var interactor: NewPlayerFormInteractorContract! { get set }
    var entity: NewPlayerFormEntityContract! { get set }
    var wireframe: NewPlayerFormWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
}

protocol NewPlayerFormInteractorContract: BaseInteractor {
    var output: NewPlayerFormInteractorOutputContract! {get set}
}

protocol NewPlayerFormInteractorOutputContract: class {
    
}

protocol NewPlayerFormWireframeContract: BaseWireframe {
    var output: NewPlayerFormWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
    
    func showBasicLoading(text: String)
    func hideBasicLoading(completion: @escaping (() -> Void))
}

protocol NewPlayerFormWireframeOutputContract: class {

}
