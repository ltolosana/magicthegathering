//
//  NewPlayerFormInteractor.swift
//  MagicTheGathering
//
//  Created by Luis Maria Tolosana Simon on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class NewPlayerFormInteractor: BaseInteractor, NewPlayerFormInteractorContract {
    weak var output: NewPlayerFormInteractorOutputContract!

    var magicProvider: MagicProviderContract
    
    init (provider: MagicProviderContract) {
        self.magicProvider = provider
    }
    
    func checkTextFieldNumWords(_ text: String, minWords: Int) -> Bool {
        let words = text.split(separator: " ")
        if words.count >= minWords {
            return true
        } else {
            return false
        }
    }
    
    func checkPhoneDigits(_ text: String) -> Bool {
        let numDigits = 11
        let numDigitsPlus = numDigits + 1
        
        if text.count == numDigitsPlus {
            return true
        } else {
            return false
        }
    }
    
    func checkEmail(_ text: String) -> Bool {
        let range = NSRange(location: 0, length: text.utf16.count)
        
        do {
            let emailRegEx = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")

            let result = emailRegEx.matches(in: text, range: range)
            if result.isEmpty {
                // No ha habido un match con la expresion regular
                return false
            } else {
                // Si que ha habido match, es decir que el email esta bien escrito
                return true
            }
        } catch {
            fatalError("Invalid regular expresion to check email")
        }
    }
    
    func checkSameTextInput(_ text: String, vs otherText: String) -> Bool {
        if text == otherText {
            // Ambos campos son iguales
            return true
        } else {
            // No son iguales
            return false
        }
    }
    
    func checkPasswordConstraints(_ text: String, minCharacters: Int) -> Bool {
        let range = NSRange(location: 0, length: text.utf16.count)
        
        // Nota: En estos dos casos concretos, me puedo permitir poner la "!" porque se seguro que
        // la expresion regular que he puesto, funciona correctamente y ademas si por algun motivo
        // un error al escribir codigo hace que se cambie la expresion,
        // nos serviria para darnos cuenta del error porque "petaria" la simulacion
        // La funcion anterior si que la he hecho con do-try-catch, jeje
        
        // swiftlint:disable:next force_try
        let regexUpper = try! NSRegularExpression(pattern: "[A-Z]")
        // swiftlint:disable:next force_try
        let regexNumbers = try! NSRegularExpression(pattern: "[0-9]")
        
        if range.length >= minCharacters &&
            regexUpper.firstMatch(in: text, options: [], range: range) != nil &&
            regexNumbers.firstMatch(in: text, options: [], range: range) != nil {
            // Comprobamos que hay minimo 8 caracteres, ha encontrado al menos una mayuscula y al menos un numero,
            // y dejamos salir
            return true
        } else {
            // En este caso falta o mayuscula o numero asi que no dejamos salir
            return false
        }
    }
    
    func checkPhoneNumber(range: NSRange, string: String) -> Bool {
        // Voy a hacer una comprobacion de prueba como si fuera para telefonos de España
        // El requisito es que empieze por un signo "+"y despues tiene exactamente 11 digitos, incluido el prefijo
        // No voy a comprobar que el prefijo sea +34, sino que se puede poner cualquier numero
        // Tambien se que hay un pequeño "bug"y es que si alguien hace un paste de un numero y el total tiene mas de 11 digitos,
        // eso no lo compruebo, y queda un numero de telefono demasiado grande.
        // Y tampoco se como formatear el numero para que aparezca como en el placeholder "+34 555 55 55 55"
        // (con los espacios en blanco)
        
        let numDigits = 11
        let numDigitsPlus = numDigits + 1
        
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
                if range.location == numDigitsPlus {
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
    
    func checkForWhiteSpaces(string: String) -> Bool {
        // Compruebo que no se escriban caracteres de espacios en blanco ni saltos de linea
        return string.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines) == nil
    }
}
