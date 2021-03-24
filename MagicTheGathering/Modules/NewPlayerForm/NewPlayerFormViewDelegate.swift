//
//  NewPlayerFormViewDelegate.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 24/3/21.
//

import UIKit

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
        let errorBackgroundColor = UIColor.systemRed.withAlphaComponent(0.2)
        
        guard let otherTextField = textField.superview?.superview?.viewWithTag(otherField.rawValue) as? UITextField else {
            return true
        }
        
        // Si ambos campos son iguales limpamos el fondo y salimos
        if textField.text == otherTextField.text {
            textField.rightViewMode = .never
            textField.backgroundColor = originalBackgroundColor
            otherTextField.rightViewMode = .never
            otherTextField.backgroundColor = originalBackgroundColor
            return true
        } else {
            // Si no son iguales ...
            switch otherField {
            case .email, .password:
                // ... y estamos en uno de los campos de repeticion, nos ponemos en rojo y no dejamos salir
                // Para que solo cree el overlayButton la primera vez
                textField.rightView = textField.rightView ?? createOverlayButton()
                textField.rightViewMode = .always
                textField.backgroundColor = errorBackgroundColor
                return false
            case .repeatEmail, .repeatPassword:
                // ... y estamos en uno de los campos principales, ponemos el de repeticion en rojo y salimos
                // Salvo que el campo de repeticion este vacio, en cuyo caso le damos al usuario la oportunidad de rellenarlo
                if otherTextField.text != "" {
                    // Para que solo cree el overlayButton la primera vez
                    otherTextField.rightView = otherTextField.rightView ?? createOverlayButton()
                    otherTextField.rightViewMode = .always
                    otherTextField.backgroundColor = errorBackgroundColor
                }
                return true
            }
        }
    }
    
    private func createOverlayButton() -> UIButton {
        let overlayButton = UIButton(type: .custom)
        overlayButton.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        overlayButton.tintColor = .systemRed
        overlayButton.sizeToFit()
        
        return overlayButton
    }

}
