//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD

        self.submitButton.frame = CGRect(x: 175, y: 800, width: 100, height: 100)
        self.submitButton.isEnabled = false

        let textFieldArray = [emailTextField, emailConfirmationTextField, phoneTextField, passwordTextField, passwordConfirmTextField]

      for textField in textFieldArray {
        textField?.delegate = self
      }

      passwordConfirmTextField.addTarget(self, action: #selector(didChangeText(_:)), for: .editingChanged)

    }

  func emailCheck() -> Bool {
    guard let text = emailTextField.text,
      let text2 = emailConfirmationTextField.text else { return false}
    if text.contains("@") && text.contains(".") && text == text2 {
      return true
    } else {
      return false
    }
  }

  func checkPhone() -> Bool {
    guard let phoneNumber = phoneTextField.text else { return false }
    if phoneNumber.characters.count > 6 && Int(phoneNumber) != nil {
      return true
    } else {
    return false
    }
  }

  func checkPassword() -> Bool {
    guard let pw1 = passwordTextField.text,
    let pw2 = passwordConfirmTextField.text else {
      return false
    }

    if pw1.characters.count > 5 && pw1 == pw2 {
      return true
    } else {
      return false
    }
  }

  @IBAction func submit(_ sender: UIButton) {
    print("you win")
  }

  func enableButton() {

    if emailCheck() && checkPhone() && checkPassword() {
        UIView.transition(with: submitButton,
                        duration: 2.0,
                        options: .allowAnimatedContent,
                        animations:  {
                          self.submitButton.frame = CGRect(x: 175, y: 400, width: 100, height: 100)
      },
                        completion: nil)
      submitButton.isEnabled = true

    } else {
      print(emailCheck())
      print(checkPhone())
      print(checkPassword())
      print("nope")
    }
  }


  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    if emailCheck() == false && emailTextField.text != "" && emailTextField.text != "" {
      pulse(textField: self.emailConfirmationTextField)
    } else if checkPhone() == false && phoneTextField.text != "" {
      pulse(textField: self.phoneTextField)
    } else if checkPassword() == false && passwordTextField.text != "" && passwordConfirmTextField.text != "" {
      pulse(textField: self.passwordConfirmTextField)
    } else if emailCheck() == false && (!(emailTextField.text?.contains("@"))! || !(emailTextField.text?.contains("."))!) {
      pulse(textField: self.emailTextField)
    } else if checkPassword() == false && (passwordTextField.text?.characters.count)! < 6 && passwordTextField.text != "" {
      pulse(textField: self.passwordTextField)
    }
    return true
  }

  func pulse(textField: UITextField) {
    UIView.animate(withDuration: 0.25,
                   animations: {
                    textField.backgroundColor = UIColor.red
                    textField.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    },
                   completion: { _ in
                    UIView.animate(withDuration: 0.25, animations: {
                      textField.backgroundColor = UIColor.white
                      textField.transform = CGAffineTransform(scaleX: 1, y: 1)
                    }, completion: nil)

    })

  }

  @IBAction func editingChanged(_ sender: UITextField) {
    enableButton()
  }

  func didChangeText(_ textField:UITextField) {
    enableButton()
  }



}
