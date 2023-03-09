//
//  ViewController.swift
//  InstagramClone
//
//  Created by Yasin Özdemir on 3.03.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var instagramLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

   
    @IBAction func signInButton(_ sender: Any) {
        if emailText.text == "" || passwordText.text == ""{
            makeAlert(title: "Error!", message: "E-mail / Password ?")}
        else{
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil{
                    self.makeAlert(title: "ERROR!", message: error?.localizedDescription ?? "ERROR")
                }else{
                    self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
                }
            }
            
        }
    }
    @IBAction func signUpButton(_ sender: Any) {
        if emailText.text == "" && passwordText.text == ""{
            makeAlert(title: "Error!", message: "E-mail / Password ?")
        }else{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authData, error in // kullanıcı oluşturma methodu
                if error != nil{
                    self.makeAlert(title:"Error!", message: error?.localizedDescription ?? "ERROR")
                }
                else{
                    self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
                }
            }
            
        }
        
    }
    
    func makeAlert(title : String , message : String){
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        var OkButton = UIAlertAction(title:"OK", style: UIAlertAction.Style.default)
        alert.addAction(OkButton)
        self.present(alert, animated: true)
    }
}

