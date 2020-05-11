//
//  TaskViewController.swift
//  listr
//
//  Created by Regmi on 2020-05-04.
//  Copyright © 2020 Regmi. All rights reserved.
//

import UIKit
import os.log

class TaskViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameTaskField: UITextField!
        
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var priorityControl: PriorityControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
        
    var  task:Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTaskField.delegate = self
        if let task = task {
            navigationItem.title = task.name
            nameTaskField.text   = task.name
            photoImageView.image = task.img
            priorityControl.priority = task.priority
        }
        updateSaveButtonState()
    }
    
    // UI Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }

    
    //MARK: UIImagePickerControllerDelegate

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        let isPresentingInAddTaskMode = presentingViewController is UINavigationController
        if isPresentingInAddTaskMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    // Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {

        let isPresentingInAddTaskMode = presentingViewController is UINavigationController
        
        if isPresentingInAddTaskMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        
    }
    
    // configures a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTaskField.text ?? ""
        let photo = photoImageView.image
        let priority = priorityControl.priority
        
        task = Task(name: name, img: photo, priority: priority) 
    }

    // Event here:
    
    @IBAction func selectImage(_ sender: UITapGestureRecognizer) {

        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            // Hide the keyboard.
            nameTaskField.resignFirstResponder()
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            present(imagePickerController, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Error", message: "Unable to access photo library.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
           let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .camera
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = self
            present(imagePickerController, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Error", message: "Unable to access camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTaskField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}
