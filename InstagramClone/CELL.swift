//
//  CELL.swift
//  InstagramClone
//
//  Created by Yasin Özdemir on 8.03.2023.
//

import UIKit
import Firebase
import FirebaseFirestore
class CELL: UITableViewCell {
    
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    var documentID = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func likeButton(_ sender: Any) {
        
        var fireStore = Firestore.firestore()
        
        var newLike = Int(likeLabel.text!)! + 1
        
        var likeData = ["like" : newLike]
        fireStore.collection("Posts").document(documentID).setData(likeData, merge: true)
    }
}
