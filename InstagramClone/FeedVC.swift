//
//  FeedVC.swift
//  InstagramClone
//
//  Created by Yasin Özdemir on 4.03.2023.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseFirestore

class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var emailArray = [String]()
    var imageUrlArray = [String]()
    var likeArray = [Int]()
    var commentArray = [String]()
    var documentIdArray = [String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getFireDataBase()
    }
    
    func getFireDataBase(){
        var firestore = Firestore.firestore()
        
        firestore.collection("Posts").order(by: "date", descending: true).addSnapshotListener { mySnapshot, error in /* collectiondan snapshot oluşturmamız gerekir çünkü
                                                                                                                      dökümantasyonları snapshot ile bir dizi şeklinde çekeriz*/
            if error != nil{
                print("error")
            }else{
                if mySnapshot?.isEmpty != true{
                    self.emailArray.removeAll()
                    self.commentArray.removeAll()
                    self.likeArray.removeAll()
                    self.imageUrlArray.removeAll()
                    self.documentIdArray.removeAll()
                    
                    for documents in mySnapshot!.documents{ // snapshot.documents dökümanları bir dizi olarak geri döndürür
                        if let documentId = documents.documentID as? String{
                            self.documentIdArray.append(documentId)
                        }
                        
                        if let email = documents.get("User E-mail") as? String{
                            self.emailArray.append(email)
                        }
                        if let comment = documents.get("comment") as? String{
                            self.commentArray.append(comment)
                        }
                        if let like = documents.get("like") as? Int{
                            self.likeArray.append(like)
                        }
                        if let imageUrl = documents.get("imageUrl") as? String{
                            self.imageUrlArray.append(imageUrl)
                        }
                    }
                    self.tableView.reloadData()
                }
                
                    
                }
            }
            
        }
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CELL
        
        cell.emailLabel.text = emailArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.commentLabel.text = commentArray[indexPath.row]
        cell.userImage.sd_setImage(with: URL(string: imageUrlArray[indexPath.row]))
        cell.documentID = documentIdArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
        
    }
   

}
