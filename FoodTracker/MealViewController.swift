//
//  ViewController.swift
//  FoodTracker
//
//  Created by UAG on 2019/7/5.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
   
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
//        mealNameLabel.text = textField.text;
    }
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //dismiss the pick if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // the info dictionary may content multiple representations of the image, You want to use
        // the original
        guard let selectImage = info[UIImagePickerController.InfoKey.originalImage] as?
        UIImage else{
            fatalError("Expect dictionary content an image, but was providing the following:\(info)")
        }
        //set photoImageView to display the selected image.
        photoImageView.image = selectImage
        //Dismiss the image picker
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: action
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // hide the keyboard
        nameTextField.resignFirstResponder();
        
        let imagePickerController = UIImagePickerController()
        
        //only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        //make sure the ViewController is notified when the user pick an image
        imagePickerController.delegate = self
        
        present(imagePickerController,animated : true,  completion: nil)
        
    }

}

