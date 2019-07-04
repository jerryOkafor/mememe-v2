//
//  ViewController.swift
//  mememe
//
//  Created by Jerry Hanks on 01/07/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var memeMeImageView: UIImageView!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var galleryBtn: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    private var clearedTopTextField  = false
     private var clearedBottomTextField  = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add action for share Button
        self.shareBtn.action = #selector(ViewController.shareMememe)
        
        //add action for Camera btn
        self.cameraBtn.action = #selector(ViewController.openCamera)
        
        //add action for open gallery
        self.galleryBtn.action = #selector(ViewController.openPhotos)
        
        //add action for cancel btn
        self.cancelBtn.action = #selector(ViewController.cancel)
        
        //dsiable camera button depending on source availability
        self.cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        //temporalyy diable the meme share buttton untils an image is picked
        shareBtn.isEnabled = false
        
        //set textFileds delegate
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        //set text attrinute for the top and bottom textFields
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.blue,
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont(name: "Impact", size: 40)!,
            NSAttributedString.Key.strokeWidth:  1.0
        ]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        //set all textFields alignment to center
        topTextField.textAlignment = NSTextAlignment.center
        bottomTextField.textAlignment = NSTextAlignment.center
    }

    @objc func shareMememe(){
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memeMeImageView.image!, memedImage: self.generateMemedImage())
        
        //use UIActivityViewController and share the memeMe
        let activityViewController = UIActivityViewController(activityItems: [meme.memedImage!], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view //so that iPads won't crash
        
        //exclude some activit types from the list
//        activityViewController.excludedActivityTypes = [.airDrop,.postToFacebook]
        
        //preset the viewcontroller
        self.present(activityViewController, animated: false, completion: nil)
    }
    
    @objc func openCamera(){
         let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType  = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func openPhotos(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType  = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func cancel(){
        shareBtn.isEnabled = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        shareBtn.isEnabled = true
        
        if let image  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            memeMeImageView.image = image
        }
        
        //dismiss the image picker
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Image picker cancelled")
        
        shareBtn.isEnabled = false
        
        //dismiss the image picker
        self.dismiss(animated: true, completion: nil)
    }

    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        topToolBar.isHidden  = true
        bottomToolBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        topToolBar.isHidden  = false
        bottomToolBar.isHidden = false
        
        return memedImage
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if  !clearedTopTextField{
            topTextField.text = ""
            clearedTopTextField = true
        }
        
        if  !clearedBottomTextField{
            bottomTextField.text  = ""
            clearedBottomTextField = true
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

