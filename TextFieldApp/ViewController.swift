//
//  ViewController.swift
//  TextFieldApp
//
//  Created by Mac on 31.03.2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var doneButton: UIButton!
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var surnameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = " "
        
        doneButton.layer.cornerRadius = 20
        doneButton.setTitle("Done", for: .normal)
        
        nameTF.delegate = self
        surnameTF.delegate = self
        nameTF.placeholder = "Enter your name"
        surnameTF.placeholder = "Enter you surname"
        nameTF.returnKeyType = .next
        surnameTF.returnKeyType = .done
        nameTF.tag = 0
        surnameTF.tag = 1
    }

    @IBAction func doneButtonPressed() {
        guard let name = nameTF.text, let surname = surnameTF.text else { return }
        
        if name.isEmpty {
            showAlert(with: "Error", and: "Enter your name please")
        } else if surname.isEmpty {
            showAlert(with: "Error", and: "Enter your surname please")
        } else {
            nameLabel.text = name + " " + surname
        }
        
    }
    // MARK: UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == nameTF || textField == surnameTF {
            let allowedCharacters = CharacterSet(charactersIn:"qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    // MARK: Alert
    func showAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    // MARK: Hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super .touchesBegan(touches, with: event)
    view.endEditing(true)
    }
    // MARK: Buttons Next & Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let nextTFTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTFTag) {
            nextResponder.becomeFirstResponder()
        } else {
            doneButtonPressed()
        }
        return true
    }
    
}

