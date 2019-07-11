//
//  MemeTableViewController.swift
//  mememe
//
//  Created by Jerry Hanks on 11/07/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    @IBOutlet weak var newMemeBtn: UIBarButtonItem!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_plus"),
            style: .plain,
            target: self,
            action: #selector(addNewMeme(_:))
        )
        
        hidesBottomBarWhenPushed = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView?.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @objc
    func addNewMeme(_ sender:UIBarButtonItem){
        let vc =  UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: MemeEditorViewController.self))
        self.navigationController?.present(vc, animated: true,completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: String(describing: MemeTableViewItem.self), for: indexPath) as! MemeTableViewItem
        
        let memeItem = memes[indexPath.row]
        cell.memeImageView.image = memeItem.memedImage
        cell.topLabel.text = memeItem.topText
        cell.bottomLabel.text = memeItem.bottomText
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meme = memes[indexPath.row]
        MemeDetailViewController.launch(self, animated: true, meme: meme)
    }
}


class MemeTableViewItem: UITableViewCell {
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
}
