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
        default:
            return true
        }
    }
}

// MARK: - Extension NewPlayerFormViewDelegate
extension NewPlayerFormViewDelegate {
    
    private func checkSameTextInput(_ textField: UITextField, vs otherField: TextFieldType) -> Bool {
        
        guard let otherTextField = textField.superview?.superview?.viewWithTag(otherField.rawValue) as? UITextField else {
            return true
        }
        
        // Si ambos campos son iguales limpamos el fondo y salimos
        if textField.text == otherTextField.text {
            clearTextFieldError(textField)
            clearTextFieldError(otherTextField)
        } else {
            // Si no son iguales ...
            switch otherField {
            case .email, .password:
                // ... y estamos en uno de los campos de repeticion, nos ponemos en rojo y dejamos salir
                // porque puede que el error este en el otro campo y asi el usuario podra arreglarlo
                setTextFieldError(textField)
            case .repeatEmail, .repeatPassword:
                // ... y estamos en uno de los campos principales, ponemos el de repeticion en rojo y salimos
                // Salvo que el campo de repeticion este vacio, en cuyo caso le damos al usuario la oportunidad de rellenarlo
                if otherTextField.text != "" {
                    setTextFieldError(otherTextField)
                }
            }
        }
        return true
    }
    
    private func checkPhoneNumber(_ textField: UITextField,
                                  shouldChangeCharactersIn range: NSRange,
                                  replacementString string: String) -> Bool {
        // Voy a hacer una comprobacion de prueba como si fuera para telefonos de España
        // El requisito es que empieze por un signo "+"y despues tiene exactamente 11 digitos, incluido el prefijo
        // No voy a comprobar que el prefijo sea +34, sino que se puede poner cualquier numero
        // Tambien se que hay un pequeño "bug"y es que si alguien hace un paste de un numero y el total tiene mas de 11 digitos,
        // eso no lo compruebo, y queda un numero de telefono demasiado grande.
        // Y tampoco se como formatear el numero para que aparezca como en el placeholder "+34 555 55 55 55"
        // (con los espaios en blanco)
        
        if range.location == 0 {
            // Es el primer elemento que se teclea
            if string == "+" {
                // En caso de que se teclee el "+" dejamos continuar
                debugPrint("Primer elemento correcto")
                return true
            } else {
                // Si no es el signo "+" no deja escribir, ni aunque se este hacendo un paste
                debugPrint("Primer elemento no valido")
                return false
            }
        } else {
            // Comprobamos el resto de elementos (menos el primero)
            if Int(string) == nil {
                // Si tecleamos algo que no es un numero
                if range.upperBound > range.lowerBound {
                    // Estamos borrando asi que esto si seria valido
                    debugPrint("Estamos borrando")
                    return true
                } else {
                    // Estamos tecleando algo que no es un numero y eso no es valido
                    debugPrint("No estas tecleando un numero")
                    return false
                }
            } else {
                // Si que es un numero asi que todo correcto
                if range.location == 12 {
                    // Hemos tecleado los 11 digitos del numero completo, ademas del "+" asi que no dejamos teclear mas
                    debugPrint("Hemos llegado al ultimo digito")
                    return false
                } else {
                    // Estamos tecleando numeros asi que dejamos continuar
                    return true
                }
            }
        }
    }
    
    // Aqui solo voy a controlar que tenga un minimo de 8 caracteres, con una mayuscula y un numero
    // Obviamente habria que controlar tambien que no haya caracteres extraños, tipo espaios en blanco
    // o caracteres no representables
    private func checkPasswordConstraints(_ textField: UITextField) -> Bool {
        let minCharacters = 8 // Minimo numero de caracteres permitidos en la password
        
        guard let textToCheck = textField.text else {
            return true
        }
        let range = NSRange(location: 0, length: textToCheck.utf16.count)
        
        // Nota: En estos dos casos concretos, me puedo permitir poner la "!" porque se seguro que
        // la expresion regular que he puesto, funciona correctamente y ademas si por algun motivo
        // un error al escribir codigo hace que se cambie la expresion,
        // nos serviria para darnos cuenta del error porque "petaria" la simulacion
        
        // swiftlint:disable:next force_try
        let regexUpper = try! NSRegularExpression(pattern: "[A-Z]")
        // swiftlint:disable:next force_try
        let regexNumbers = try! NSRegularExpression(pattern: "[0-9]")
        
        if range.length >= minCharacters &&
            regexUpper.firstMatch(in: textToCheck, options: [], range: range) != nil &&
            regexNumbers.firstMatch(in: textToCheck, options: [], range: range) != nil {
            // Comprobamos que hay minimo 8 caracteres, ha encontrado al menos una mayuscula y al menos un numero,
            // asi que limpiamos un posible error anterior y dejamos salir
            clearTextFieldError(textField)
            return true
        } else {
            // En este caso falta o mayuscula o numero asi que no dejamos salir
            setTextFieldError(textField)
            return false
        }
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
        let originalBackgroundColor = UIColor.white
        
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
