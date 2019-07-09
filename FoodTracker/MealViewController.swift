//
//  ViewController.swift
//  FoodTracker
//
//  Created by UAG on 2019/7/5.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
  
    /* This value is either passed by "MealTableViewController" or in
     'prepare(for:sender:)'
     or constructed as party of adding a new meal.
     */
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // handle the field's user input throth txet delegete callbacks
        //  When a ViewController instance is loaded, it sets itself as the delegate of its nameTextField property.
        nameTextField.delegate = self;
        
        //set up views of editing an existing meal
        if let meal = meal{
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        //Enable the save button only if the text fiel has a valid Meal name
       updataSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide the keyboard
        textField.resignFirstResponder();
        return true;
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // do some thing
//        mealNameLabel.text = textField.text;
        updataSaveButtonState()
        navigationItem.title = textField.text
        
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
    //MARK: navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPreseningInAddMealMode = presentedViewController is UINavigationController
        if isPreseningInAddMealMode{
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else{
            fatalError("The MealviewController is not inside the navigation controller.")
        }
    }
    
    //this method let you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("the save button was not pressed ,cancelling", log:OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        //set the meal to be pressed to mealtableviewController after the unwind segue
        meal = Meal(name: name, photo: photo, rating: rating)
        
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
    
    //MARK: private methods
    private func updataSaveButtonState() {
        //disable the save button if the text field if empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}

