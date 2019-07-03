//
//  ViewController.swift
//  mememe
//
//  Created by Jerry Hanks on 01/07/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var galleryBtn: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
    }

    @objc func shareMememe(){
        print("Sharing Mememe")
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
        print("Cancel")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Image picked: \(info)")
        
        //dismiss the image picker
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Image picker cancelled")
        
        //dismiss the image picker
        self.dismiss(animated: true, completion: nil)
    }

}

