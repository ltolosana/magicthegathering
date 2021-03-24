//
//  NewPlayerFormView.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class NewPlayerFormView: BaseViewController, NewPlayerFormViewContract {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var aliasTextField: UITextField!
    @IBOutlet weak var planeskalkerTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var repeatEmailTextField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var presenter: NewPlayerFormPresenterContract!
    
    // swiftlint:disable:next weak_delegate
    private var textFieldsDelegate: UITextFieldDelegate = NewPlayerFormViewDelegate()

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
        nameTextField.tag = 0
        nameTextField.delegate = textFieldsDelegate
        aliasTextField.tag = 1
        aliasTextField.delegate = textFieldsDelegate
        planeskalkerTextField.tag = 2
        planeskalkerTextField.delegate = textFieldsDelegate
        phoneTextField.tag = 3
        phoneTextField.delegate = textFieldsDelegate
        emailTextField.tag = 4
        emailTextField.delegate = textFieldsDelegate
        repeatEmailTextField.tag = 5
        repeatEmailTextField.delegate = textFieldsDelegate
        passwordTxtField.tag = 6
        passwordTxtField.delegate = textFieldsDelegate
        repeatPasswordTextField.tag = 7
        repeatPasswordTextField.delegate = textFieldsDelegate

    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
    }
}

// En este caso en vez de hacer como suelo hacer yo habitualmente, de usar una extension y que el delegado sea self,
// voy a ahcer como has hecho tu y crear una nueva clase que se conforma con el protocolo de UITextFieldDelegate

class NewPlayerFormViewDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextTextField = textField.superview?.superview?.viewWithTag(nextTag) {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    
    }
    
}
