//
//  MemeCollectionViewController.swift
//  mememe
//
//  Created by Jerry Hanks on 11/07/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_plus"),
            style: .plain,
            target: self,
            action: #selector(addNewMeme(_:))
        )
    }
    
    @objc
    private func addNewMeme(_ sender:UIBarButtonItem){
        let vc =  UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: MemeEditorViewController.self))
        self.navigationController?.present(vc, animated: true,completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
