//
//  MemeDetailViewController.swift
//  mememe
//
//  Created by Jerry Hanks on 11/07/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var originalImageView: UIImageView!
    @IBOutlet weak var memedImageView: UIImageView!
    @IBOutlet weak var topTextLabel: UILabel!
    @IBOutlet weak var bottomTextLabel: UILabel!
    
    internal var meme:Meme!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let meme = meme{
            originalImageView.image = meme.originalImage
            memedImageView.image = meme.memedImage
            topTextLabel.text = meme.topText
            bottomTextLabel.text = meme.bottomText
        }
        
        
        //add edit button here
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action:#selector(editMeme(_:)) )
    }
    
    @objc
    private func editMeme(_ sender:UIBarButtonItem){
        MemeEditorViewController.launch(self, animated: true, meme: meme)
    }

    static func launch(_ caller:UIViewController, animated:Bool,meme:Meme?){
        let vc  = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: self)) as! MemeDetailViewController
        vc.meme = meme
        vc.hidesBottomBarWhenPushed = true
        caller.navigationController?.pushViewController(vc, animated: animated)
    }
}
