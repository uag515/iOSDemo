//
//  ViewController.swift
//  FoodTracker
//
//  Created by UAG on 2019/7/5.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // handle the field's user input throth txet delegete callbacks
        //  When a ViewController instance is loaded, it sets itself as the delegate of its nameTextField property.
        nameTextField.delegate = self;
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide the keyboard
        textField.resignFirstResponder();
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // do some thing
        mealNameLabel.text = textField.text;
    }
    //MARK: action
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "chicken chicken !"
    }
    
}

