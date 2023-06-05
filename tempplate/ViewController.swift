//
//  ViewController.swift
//  tempplate
//
//  Created by isoftstone on 2023/5/19.
//

import UIKit
import FDLibrary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchBtnAction(_ sender: UIButton) {
        let searchVC = SearchVC()
        let nav = BaseNavigationC(rootViewController: searchVC)
        present(nav, animated: true, completion: nil)
    }
    
}

