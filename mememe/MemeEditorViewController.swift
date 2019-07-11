//
//  ViewController.swift
//  mememe
//
//  Created by Jerry Hanks on 01/07/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit
import CropViewController

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var memeMeImageView: UIImageView!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var cropBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var galleryBtn: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    private var clearedTopTextField  = false
    private var clearedBottomTextField  = false
    private var isEditingBottomTextField = false
    
    internal var meme:Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add action for share Button
        self.shareBtn.action = #selector(MemeEditorViewController.shareMememe)
        
        //add action for cropping
        self.cropBtn.action = #selector(MemeEditorViewController.cropImage(_:))
        
        //add action for Camera btn
        self.cameraBtn.action = #selector(MemeEditorViewController.openCamera)
        
        //add action for open gallery
        self.galleryBtn.action = #selector(MemeEditorViewController.openPhotos)
        
        //add action for cancel btn
        self.cancelBtn.action = #selector(MemeEditorViewController.cancel)
        
        //dsiable camera button depending on source availability
        self.cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        //set textFileds delegate
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        //setup top and bottom textField
        setupTextField(topTextField, tag: 0)
        setupTextField(bottomTextField, tag: 1)
        
        //make toolbar seamles with the view background
        self.topToolBar.setShadowImage(UIImage(), forToolbarPosition: .any)
//        self.bottomToolBar.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        
        //set the meme if we are in edit mode
        if let meme = meme{
            memeMeImageView.image = meme.originalImage
            topTextField.text = meme.topText
            bottomTextField.text = meme.bottomText
        }else{
            
            //temporalyy diable the meme share buttton untils an image is picked
            shareBtn.isEnabled = false
        }
    }
    

    private func setupTextField(_ textField:UITextField, tag:Int){
        
        //set text attrinute for the top and bottom textFields
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Impact", size: 40)!,
            .strokeWidth:  -1.0
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        
        //add tags to the textFields so that we can track
        textField.tag = tag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotifications()
    }
    

    @objc func shareMememe(){
        let memedImage = self.generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memeMeImageView.image!, memedImage:memedImage)
        
        //use UIActivityViewController and share the memeMe
        let activityViewController = UIActivityViewController(activityItems: [meme.memedImage!], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view //so that iPads won't crash
        
        //only save the memed image when the activity view is completed.
        activityViewController.completionWithItemsHandler = {(activity, completed, items, error ) in
            if completed{
                print("Completed meme sharing")
                self.save(meme: meme)
                
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        //preset the viewcontroller
        self.present(activityViewController, animated: false, completion: nil)
    }
    
    
    @objc
    private func cropImage(_ sender:UIBarButtonItem){
        if let image = memeMeImageView.image{
            let cropViewController = CropViewController(image: image)
            cropViewController.customAspectRatio = CGSize(width: 200, height: 400)
            cropViewController.delegate = self
            present(cropViewController, animated: true, completion: nil)
        }
        
    }
    @objc
    private func openCamera(){
         presentPickerViewController(.camera)
    }
    
    @objc
    private func openPhotos(){
        presentPickerViewController(.photoLibrary)
    }
    
    
    private func presentPickerViewController(_ sourceType : UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType  = sourceType
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
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
        //dismiss the image picker
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func save(meme:Meme){
        //add save meme code here in v2.0
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
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
    
    @objc func keyboardWillShow(_ notifications:Notification){
        if isEditingBottomTextField{
            self.view.frame.origin.y = -getKeyboardHeight(notifications)
        }
        
    }
    
    @objc func keyboardWillHide(_ notifications:Notification){
       self.view.frame.origin.y = 0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if  !clearedTopTextField && meme == nil{
            topTextField.text = ""
            clearedTopTextField = true
        }
        
        if  !clearedBottomTextField  && meme == nil {
            bottomTextField.text  = ""
            clearedBottomTextField = true
        }
        
        if textField.tag == bottomTextField.tag{
            isEditingBottomTextField = true
        }else{
            isEditingBottomTextField = false
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func subscribeToKeyboardNotifications(){
        
        //will show
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //will hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        //will show
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //will hide
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(_ notifications:Notification)->CGFloat{
        let userInfo = notifications.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    static func launch(_ caller:UIViewController,animated:Bool = true,meme:Meme?){
        let vc =  UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: MemeEditorViewController.self)) as! MemeEditorViewController
        
        vc.hidesBottomBarWhenPushed = true
        vc.meme = meme
        
        caller.present(vc, animated: animated,completion: nil)

    }
}


//Extension for image cropping
extension MemeEditorViewController : CropViewControllerDelegate{
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
        self.memeMeImageView.image  = image
        
        //dismiss
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
}
