//
//  MemeCollectionViewController.swift
//  mememe
//
//  Created by Jerry Hanks on 11/07/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
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
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    @objc
    private func addNewMeme(_ sender:UIBarButtonItem){
        let vc =  UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: MemeEditorViewController.self))
        self.navigationController?.present(vc, animated: true,completion: nil)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MemeCollectionItem.self), for: indexPath) as! MemeCollectionItem
        
        let memeItem = memes[indexPath.row]
        cell.memeImageView.image = memeItem.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme = memes[indexPath.row]
        MemeDetailViewController.launch(self, animated: true, meme: meme)
    }
}


class MemeCollectionItem: UICollectionViewCell {
    @IBOutlet weak var memeImageView: UIImageView!
    
}
