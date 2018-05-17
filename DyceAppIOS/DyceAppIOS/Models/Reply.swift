import Foundation
import UIKit
import Firebase
import SCLAlertView
import SVProgressHUD
class Reply {
    
    var uid: String
    var username: String
    var reply: String
    var postID: String = ""
    var time : Timestamp
    
    init(_uid: String, _username: String, _reply: String , _time : Timestamp) {
        uid = _uid
        username = _username
        reply = _reply
        time = _time
    }
    init() {
        uid = ""
        username = ""
        reply = ""
        time = Timestamp(date: Date(timeIntervalSinceNow: 0)) 
    }
    func pushToFirestore(){
        //firebase references
        let replyCollectoin: CollectionReference = Firestore.firestore().collection(NameFile.Firestore.FirestorePosts).document(postID).collection(NameFile.Firestore.replies)
        replyCollectoin.document().setData([
            NameFile.Firestore.replyUID : self.uid,
            NameFile.Firestore.replyUsername : self.username,
            NameFile.Firestore.reply : self.reply,
            NameFile.Firestore.replyTime : self.time
            ])
        SVProgressHUD.dismiss()
    }
}

