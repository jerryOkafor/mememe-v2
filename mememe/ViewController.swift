//
//  ViewController.swift
//  mememe
//
//  Created by Jerry Hanks on 01/07/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var galleryBtn: UIBarButtonItem!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
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
    }

    @objc func shareMememe(){
        print("Sharing Mememe")
    }
    
    @objc func openCamera(){
        print("Open Camera")
    }
    
    @objc func openPhotos(){
        print("Open photos")
    }
    
    @objc func cancel(){
        print("Cancel")
    }

}

