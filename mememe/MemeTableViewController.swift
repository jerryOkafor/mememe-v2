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
    
//    var memes: [Meme]! {
//        let object = UIApplication.shared.delegate
//        let appDelegate = object as! AppDelegate
//        return appDelegate.memes
//    }

    var memes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         self.memes.append(Meme(topText: "T##String?", bottomText: "T##String?", originalImage: UIImage(), memedImage: UIImage()))
        
         self.memes.append(Meme(topText: "T##String?", bottomText: "T##String?", originalImage: UIImage(), memedImage: UIImage()))
         self.memes.append(Meme(topText: "T##String?", bottomText: "T##String?", originalImage: UIImage(), memedImage: UIImage()))
         self.memes.append(Meme(topText: "T##String?", bottomText: "T##String?", originalImage: UIImage(), memedImage: UIImage()))
    
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "ic_plus"),
            style: .plain,
            target: self,
            action: #selector(addNewMeme(_:))
        )

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
        
        return cell
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


class MemeTableViewItem: UITableViewCell {
    
}
