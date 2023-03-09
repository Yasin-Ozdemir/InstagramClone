//
//  SettingsVC.swift
//  InstagramClone
//
//  Created by Yasin Özdemir on 4.03.2023.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logOutButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toVC", sender: nil)
        }catch{print("ERROR")}
        
        
    }
}
