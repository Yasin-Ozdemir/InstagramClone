//
//  UploadVC.swift
//  InstagramClone
//
//  Created by Yasin Özdemir on 4.03.2023.
//

import UIKit
import Firebase
import FirebaseStorage



class UploadVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentText: UITextField!
    
    
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        shareButton.isEnabled = false
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    @objc func selectImage(){
        var picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
   @IBAction func shareButton(_ sender: Any) {
       // resmi kaydetme
       let storage = Storage.storage()
       let storageReference = storage.reference() // reference kaydetme işleminde kullanılması zorunlu resim yada veri tabanı işlerinde referans verilmesi gerekir
       let mediaFolder = storageReference.child("media")
       
       let data = imageView.image?.jpegData(compressionQuality: 0.5)
       let id = UUID().uuidString
       let imageFolder = mediaFolder.child("\(id).jpg")
       
       imageFolder.putData(data!) { metadata, error in
           if error != nil {
               self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "Upload Error" )
           }else{
               imageFolder.downloadURL { [self] url, error in
                   if error != nil{
                       self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "Upload Error" )
                   }else{
                       let imageUrl = url?.absoluteString
                       
                       
                       // veri tabanı
                       let fireStore = Firestore.firestore()
                       
                       
                       // FIRE STORE ' A VERİLER DICTIONARY İLE EKLENİR
                       
                       var documents = ["User E-mail":Auth.auth().currentUser?.email , "comment":self.commentText.text , "like" : 0 , "date" : FieldValue.serverTimestamp() , "imageUrl" : imageUrl]
                       let fireStoreReference = fireStore.collection("Posts").addDocument(data: documents) { error in
                           if error != nil{
                               self.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "Error")
                           }else{
                               self.imageView.image = UIImage(systemName: "photo")
                               self.commentText.text = ""
                               self.tabBarController?.selectedIndex = 0
                           }
                       }
                   }
                   
                   
               }
           }
           
           
       }
       
    
       
       
       
       
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as! UIImage
        shareButton.isEnabled = true
        self.dismiss(animated: true)
        
    }
    
    func makeAlert(title:String , message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let OkButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(OkButton)
        self.present(alert, animated: true)
    }
}
