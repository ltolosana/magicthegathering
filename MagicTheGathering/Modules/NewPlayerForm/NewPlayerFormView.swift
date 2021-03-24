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
}

// MARK: - UITextFieldDelegate
// En este caso en vez de hacer como suelo hacer yo habitualmente, de usar una extension y que el delegado sea self,
// voy a hacer como has hecho tu y crear una nueva clase que se conforma con el protocolo de UITextFieldDelegate

class NewPlayerFormViewDelegate: NSObject, UITextFieldDelegate {
    enum TextFieldType: Int {
        case email = 4
        case repeatEmail = 5
        case password = 6
        case repeatPassword = 7
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextTextField = textField.superview?.superview?.viewWithTag(nextTag) {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
         
        switch textField.tag {

        case 4:
            return checkSameTextInput(textField, vs: .repeatEmail)
        case 5:
            return checkSameTextInput(textField, vs: .email)
        case 6:
            return checkSameTextInput(textField, vs: .repeatPassword)
        case 7:
            return checkSameTextInput(textField, vs: .password)
        default:
            return true
        }
    }
}

// MARK: - Extension NewPlayerFormViewDelegate
extension NewPlayerFormViewDelegate {
        
    private func checkSameTextInput(_ textField: UITextField, vs otherField: TextFieldType) -> Bool {
        let originalBackgroundColor = UIColor.white
        let errorBackgroundColor = UIColor.systemRed
        
        guard let otherTextField = textField.superview?.superview?.viewWithTag(otherField.rawValue) as? UITextField else {
            return true
        }
        
        // Si ambos campos son iguales limpamos el fondo y salimos
        if textField.text == otherTextField.text {
            textField.backgroundColor = originalBackgroundColor
            otherTextField.backgroundColor = originalBackgroundColor
            return true
        } else {
            // Si no son iguales ...
            switch otherField {
            case .email, .password:
                // ... y estamos en uno de los campos de repeticion, nos ponemos en rojo y no dejamos salir
                textField.backgroundColor = errorBackgroundColor
                return false
            case .repeatEmail, .repeatPassword:
                // ... y estamos en uno de los campos principales, ponemos el de repeticion en rojo y salimos
                // Salvo que el campo de repeticion este vacio, en cuyo caso le damos al usuario la oportunidad de rellenarlo
                if otherTextField.text != "" {
                    otherTextField.backgroundColor = errorBackgroundColor
                }
                return true
            }
        }
    }
}
