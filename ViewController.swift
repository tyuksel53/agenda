//
//  ViewController.swift
//  Agenda
//
//  Created by Taha Yüksel on 31.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progress: KYCircularProgress!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progress.colors = [UIColor(red: 0.94, green: 0.60, blue: 0.36, alpha: 1.00)]
        progress.progress = 0.7
        
        //progress.transform = progress.transform.rotated(by: .pi * 1.5)
        // Do any additional setup after loading the view.
    }


}

