//
//  ViewController.swift
//  JumpRightIn
//
//  Created by Kai Jendo on 6/10/17.
//  Copyright © 2017 KaiJendo. All rights reserved.
//

import UIKit
import os.log
class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    var meal: Meal?
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingController!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    //MARK: UITextFiledDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    //MARK: Private methods
    private func updateSaveButtonState() {
        let text = nameTextFiled.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let seletedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Error \(info)")
        }
        
        photoImageView.image = seletedImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: UINavigationControllerDelegate
    
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextFiled.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: Any) {
        //Depending on style of presention ( modal and push presention), this view controller needs to dismissed in two different ways
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationVC = navigationController {
            owningNavigationVC.popViewController(animated: true)
        } else {
            fatalError("The MealVC is not inside a navigation controller.")
        }
    }
    
    // The method configure the view before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Config destination VC only when the save button is present
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            os_log("The save button was not present, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextFiled.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // Set the meal to be passed to MealVC after the unwind segue
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field user input thorough delegate call-back
        nameTextFiled.delegate = self
        
        // Setup views if editting an existing Meal
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextFiled.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        // Enable the button save if value valid
        updateSaveButtonState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

