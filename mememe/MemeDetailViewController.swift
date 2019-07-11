//
//  MemeDetailViewController.swift
//  mememe
//
//  Created by Jerry Hanks on 11/07/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme:Meme!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    static func launch(_ caller:UIViewController, animated:Bool,meme:Meme){
        let vc  = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: self)) as! MemeDetailViewController
        vc.meme = meme
        caller.navigationController?.pushViewController(vc, animated: animated)
    }
}
