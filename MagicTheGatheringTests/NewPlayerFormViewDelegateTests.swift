//
//  NewPlayerFormViewDelegateTests.swift
//  MagicTheGatheringTests
//
//  Created by Luis Maria Tolosana Simon on 26/3/21.
//

@testable import MagicTheGathering
import XCTest

class NewPlayerFormViewDelegateTests: XCTestCase {

    func testGivenPasswordWhenCheckConstraintsThenComplainsPasswordPolicy() {
        let delegate = NewPlayerFormViewDelegate()
        
        let passwordTxtField = UITextField()
        passwordTxtField.tag = 6
        passwordTxtField.clearButtonMode = .always
        passwordTxtField.clearsOnBeginEditing = true
        passwordTxtField.clearsOnInsertion = true
        passwordTxtField.passwordRules =
            UITextInputPasswordRules(descriptor: "required: upper; required: digit; allowed: upper; minlength: 8;")

        // Passwords incorrectas
        let dummyPasswordShort = "Paco1"
        passwordTxtField.text = dummyPasswordShort
        XCTAssertFalse(delegate.textFieldShouldEndEditing(passwordTxtField))
        
        let dummyPasswordOnlyLetters = "muchasletras"
        passwordTxtField.text = dummyPasswordOnlyLetters
        XCTAssertFalse(delegate.textFieldShouldEndEditing(passwordTxtField))
        
        let dummyPasswordOnlyNumbers = "1234556789"
        passwordTxtField.text = dummyPasswordOnlyNumbers
        XCTAssertFalse(delegate.textFieldShouldEndEditing(passwordTxtField))
        
        let dummyPasswordOnlyUppercase = "PASSWORD"
        passwordTxtField.text = dummyPasswordOnlyUppercase
        XCTAssertFalse(delegate.textFieldShouldEndEditing(passwordTxtField))
        
        let dummyPasswordUppercaseWithoutNumber = "MiPassword"
        passwordTxtField.text = dummyPasswordUppercaseWithoutNumber
        XCTAssertFalse(delegate.textFieldShouldEndEditing(passwordTxtField))
        
        let dummyPasswordNumberWithoutUppercase = "c0ntras3nya"
        passwordTxtField.text = dummyPasswordNumberWithoutUppercase
        XCTAssertFalse(delegate.textFieldShouldEndEditing(passwordTxtField))
        
        // Password correcta
        let dummyPasswordSuccess = "Estas1qu33sta0k"
        passwordTxtField.text = dummyPasswordSuccess
        XCTAssertTrue(delegate.textFieldShouldEndEditing(passwordTxtField))
        
        // Ahora mismo no compruebo que estas contraseñas con espacios en blanco
        // pero es algo que tendria que hacer mas adelante
        let dummyPasswordToAvoid = "Evitar est0"
        passwordTxtField.text = dummyPasswordToAvoid
        XCTAssertTrue(delegate.textFieldShouldEndEditing(passwordTxtField))
    }
}
