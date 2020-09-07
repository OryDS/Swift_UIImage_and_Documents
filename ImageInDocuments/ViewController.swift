//
//  ViewController.swift
//  ImageInDocuments
//
//  Created by Orazio Conte on 06/09/2020.
//  Copyright © 2020 Orazio Conte. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Image elements
    @IBOutlet var IMGGallery: UIImageView!
    @IBOutlet var IMGDocuments: UIImageView!
    
    // Variable to name your own image
    let user = "MyImage"
    
    // Get access for the camera roll / gallery
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call the delegate to see the picture
        imagePicker.delegate = self
    }
    
    // Get an image from the camera roll / gallery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Do image check to get it original or edited
        if let IMG = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            // Get image in IMGGallery element
            IMGGallery.image = IMG
            
        } else if let IMG = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            // Get image to IMG element
            IMGGallery.image = IMG
            
        } else {
            print("Something went wrong")
        }
        
        // Close the ImagePickerController
        self.dismiss(animated: true)
    }
    
    // Get image from Gallery
    @IBAction func FromGallery(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            
            // I choose the place to fish the image
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            
            // Block the ability to edit photos
            imagePicker.allowsEditing = true
            
            // Show the imagePickerController on the screen
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // Support method for the directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @IBAction func InDocuments(_ sender: Any) {
        // Set your image
        let image: UIImage? = IMGGallery.image
        
        if (image != nil) {
            // Get ipeg file with quality range (0.0 min. > 1.0 max)
            if let data = image!.jpegData(compressionQuality: 1.0) {
                // File path from gallery to Documents app folder
                let filename = getDocumentsDirectory().appendingPathComponent("\(user).jpg")
                
                // Write the image in the folder
                try? data.write(to: filename)
                print("🤖🤓 THE INSERTION PATH IS: \(filename)")
            }
        }
    }
    
    @IBAction func FromDocuments(_ sender: Any) {
        // File path from Documents folder to image element
        let imageURL = getDocumentsDirectory().appendingPathComponent("\(user).jpg")
        
        // Assign the element type
        let image = UIImage(contentsOfFile: imageURL.path)
        
        // Get image in IMGDocuments element
        IMGDocuments.image = image!
        print("😎🏁🏆 THE RETURN PATH IS: \(imageURL)")
    }
    
    
    
}

