//
//  ViewController.swift
//  WhatIsIt
//
//  Created by Fabio Quintanilha on 12/2/17.
//  Copyright © 2017 Fabio Quintanilha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "GoToImageRecognition", sender: self)
    }
    
}

