//
//  NewPlayerFormViewDelegate.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 24/3/21.
//

import UIKit

// MARK: - UITextFieldDelegate
// Al principio queria usar una clase para el delegado, como soleis hacer, pero no sabia como poder llamar al presenter.
// asi que al final he decidido hacer una extension de la clase que implemente el protocolo de delegado
// y asi poder acceder al presenter

extension NewPlayerFormView: UITextFieldDelegate {
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
        
        case 0:
            return checkTextFieldNumWords(textField, minWords: 2)
        case 1:
            return checkTextFieldNumWords(textField, minWords: 1)
        case 2:
            return checkTextFieldNumWords(textField, minWords: 1)
        case 3:
            return checkPhoneDigits(textField)
        case 4:
            return checkEmail(textField) && checkSameTextInput(textField, vs: .repeatEmail)
        case 5:
            return checkEmail(textField) && checkSameTextInput(textField, vs: .email)
        case 6:
            // Aqui hago una doble comprobacion, la de los requerimientos de la contraseña (cantidad de caracteres,
            // mayuscula y numero) y la de que coincida la contraseña con la del campo de repetirla
            return checkPasswordConstraints(textField) && checkSameTextInput(textField, vs: .repeatPassword)
        case 7:
            // En el simulador no van muy bien las pruebas de esto y para poder probar
            // hay que deshabilitar la opcion de "Secure Text Entry'en el textfield del .xib
            return checkSameTextInput(textField, vs: .password)
        default:
            return true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField.tag {
        
        case 3:
            return checkPhoneNumber(textField, shouldChangeCharactersIn: range, replacementString: string)
        case 4:
            return checkforWhiteSpaces(textField, shouldChangeCharactersIn: range, replacementString: string)
        case 5:
            return checkforWhiteSpaces(textField, shouldChangeCharactersIn: range, replacementString: string)
        case 6:
            return checkforWhiteSpaces(textField, shouldChangeCharactersIn: range, replacementString: string)
        case 7:
            return checkforWhiteSpaces(textField, shouldChangeCharactersIn: range, replacementString: string)
        default:
            return true
        }
    }

    // MARK: - Private methods for checking
    
    // Hago una comprobacion muy basica y por ejemplo no compruebo que haya espacios en blanco al principio ni nada mas avanzado
    private func checkTextFieldNumWords(_ textField: UITextField, minWords: Int) -> Bool {
        guard let textToCheck = textField.text else {
            setTextFieldError(textField)
            return false
        }
        let check = presenter.onCheckTextFieldNumWords(textToCheck, minWords: minWords)
        if check {
            clearTextFieldError(textField)
            return true
        } else {
            setTextFieldError(textField)
            return false
        }
    }
    
    private func checkPhoneDigits(_ textField: UITextField) -> Bool {
        guard let textToCheck = textField.text else {
            setTextFieldError(textField)
            return false
        }
        let check = presenter.onCheckPhoneDigits(textToCheck)
        if check {
            clearTextFieldError(textField)
            return true
        } else {
            setTextFieldError(textField)
            return false
        }
    }
    
    private func checkEmail(_ textField: UITextField) -> Bool {
        guard let textToCheck = textField.text else {
            setTextFieldError(textField)
            return false
        }
        let check = presenter.onCheckEmail(textToCheck)
        if check {
            clearTextFieldError(textField)
            return true
        } else {
            setTextFieldError(textField)
            return false
        }

    }
    
    private func checkSameTextInput(_ textField: UITextField, vs otherField: TextFieldType) -> Bool {
        
        guard let otherTextField = textField.superview?.superview?.viewWithTag(otherField.rawValue) as? UITextField else {
            return true
        }
        
        guard let textToCheck = textField.text, let otherTextToCkeck = otherTextField.text else {
            setTextFieldError(textField)
            return false
        }
        let check = presenter.onCheckSameTextInput(textToCheck, vs: otherTextToCkeck)
        if check {
            // Si ambos campos son iguales limpamos el fondo de los dos y salimos
            clearTextFieldError(textField)
            clearTextFieldError(otherTextField)
            return true
        } else {
            // Si no son iguales ...
            switch otherField {
            case .email, .password:
                // ... y estamos en uno de los campos de repeticion, nos ponemos en rojo y dejamos salir
                // porque puede que el error este en el otro campo y asi el usuario podra arreglarlo
                setTextFieldError(textField)
                return true
            case .repeatEmail, .repeatPassword:
                // ... y estamos en uno de los campos principales, ponemos el de repeticion en rojo y salimos
                // Salvo que el campo de repeticion este vacio, en cuyo caso le damos al usuario la oportunidad de rellenarlo
                if otherTextField.text != "" {
                    setTextFieldError(otherTextField)
                }
                return true
            }
        }
    }
    
    // Aqui solo voy a controlar que tenga un minimo de 8 caracteres, con una mayuscula y un numero
    // Obviamente habria que controlar tambien que no haya caracteres extraños, tipo espaios en blanco
    // o caracteres no representables
    private func checkPasswordConstraints(_ textField: UITextField) -> Bool {
        let minCharacters = 8 // Minimo numero de caracteres permitidos en la password
        
        guard let textToCheck = textField.text else {
            setTextFieldError(textField)
            return false
        }
        
        let check = presenter.onCheckPasswordConstraints(textToCheck, minCharacters: minCharacters)
        if check {
            // Limpiamos un posible error anterior y dejamos salir
            clearTextFieldError(textField)
            return true
        } else {
            // Falta o mayuscula o numero asi que no dejamos salir
            setTextFieldError(textField)
            return false
        }
    }
    
    private func checkPhoneNumber(_ textField: UITextField,
                                  shouldChangeCharactersIn range: NSRange,
                                  replacementString string: String) -> Bool {
        return presenter.onCheckPhoneNumber(range: range, string: string)
    }
    
    private func checkforWhiteSpaces(_ textField: UITextField,
                                     shouldChangeCharactersIn range: NSRange,
                                     replacementString string: String) -> Bool {
        // Compruebo que no se escriban caracteres de espacios en blanco ni saltos de linea
        return presenter.onCheckForWhiteSpaces(string: string)
    }
    
    // MARK: - Auxiliary methods
    private func setTextFieldError(_ textField: UITextField) {
        let errorBackgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
        
        // Para que solo cree el overlayButton la primera vez
        textField.leftView = textField.leftView ?? createOverlayButton()
        textField.leftViewMode = .always
        textField.backgroundColor = errorBackgroundColor
    }
    
    private func clearTextFieldError(_ textField: UITextField) {
        let originalBackgroundColor = UIColor.systemBackground
        
        textField.leftViewMode = .never
        textField.backgroundColor = originalBackgroundColor
    }
    
    private func createOverlayButton() -> UIButton {
        let overlayButton = UIButton(type: .custom)
        overlayButton.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        overlayButton.tintColor = .systemRed
        overlayButton.sizeToFit()
        
        return overlayButton
    }
}
