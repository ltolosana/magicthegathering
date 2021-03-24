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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presenter.viewWillDisappear()
        
    }
    
    private func setupView() {
        nameTextField.tag = 0
        nameTextField.clearButtonMode = .always
        nameTextField.delegate = textFieldsDelegate
        aliasTextField.tag = 1
        aliasTextField.clearButtonMode = .always
        aliasTextField.delegate = textFieldsDelegate
        planeskalkerTextField.tag = 2
        planeskalkerTextField.clearButtonMode = .always
        planeskalkerTextField.delegate = textFieldsDelegate
        phoneTextField.tag = 3
        phoneTextField.clearButtonMode = .always
        phoneTextField.delegate = textFieldsDelegate
        emailTextField.tag = 4
        emailTextField.clearButtonMode = .always
        emailTextField.delegate = textFieldsDelegate
        repeatEmailTextField.tag = 5
        repeatEmailTextField.clearButtonMode = .always
        repeatEmailTextField.delegate = textFieldsDelegate
        passwordTxtField.tag = 6
        passwordTxtField.clearButtonMode = .always
        passwordTxtField.clearsOnBeginEditing = true
        passwordTxtField.clearsOnInsertion = true
        passwordTxtField.delegate = textFieldsDelegate
        repeatPasswordTextField.tag = 7
        repeatPasswordTextField.clearButtonMode = .always
        repeatPasswordTextField.clearsOnBeginEditing = true
        repeatPasswordTextField.clearsOnInsertion = true
        repeatPasswordTextField.delegate = textFieldsDelegate
        
        setupTextFieldsFont()
        scrollView.keyboardDismissMode = .onDrag
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
    }
}

// MARK: - Extension
extension NewPlayerFormView {

    func addObservers() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil, queue: nil) { notification in
                self.keyboardWillShow(notification: notification)
            }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil, queue: nil) { notification in
                self.keyboardWillHide(notification: notification)
            }
    }

    func removeObservers() {
            NotificationCenter.default.removeObserver(self)
        }
    
    private func keyboardWillShow(notification: Notification) {
            guard let userInfo = notification.userInfo,
                  let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                    return
            }
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
            scrollView.contentInset = contentInset
    }

    private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
     }
    
    private func setupTextFieldsFont() {
        if let magicFont = UIFont(name: Constants.magicFont, size: 14) {
            nameTextField.font = magicFont
            aliasTextField.font = magicFont
            planeskalkerTextField.font = magicFont
            emailTextField.font = magicFont
            repeatEmailTextField.font = magicFont
            passwordTxtField.font = magicFont
            repeatPasswordTextField.font = magicFont
        }
    }
}
