import Foundation
import UIKit
import Firebase
import CoreLocation
import SVProgressHUD
import GeoFire
class Question {
    var geofireRef : DatabaseReference!
    var geoFire : GeoFire!
    var creatorUID: String
    var creatorUsername: String
    var creatorProfileImage: UIImage
    
    var postID: String
    var category: String
    var time: Timestamp
    var location : GeoPoint
    var question: String
    var numReplies: Int
    var image: UIImage?
    var questionImageURL: URL?
    
<<<<<<< HEAD
    init(_creatorUID: String, _creatorUsername: String, _creatorProfileImage: UIImage = #imageLiteral(resourceName: "default"), _postID: String, _category: String, _time: Timestamp, _location: GeoPoint, _question: String, _numReplies: Int, _image: UIImage? = nil) {
=======
    init(_creatorUID: String, _creatorUsername: String, _postID: String, _location : GeoPoint , _category: String, _time: Timestamp, _question: String, _numReplies: Int, _image: UIImage? = nil) {
        geofireRef = Database.database().reference()
        geoFire = GeoFire(firebaseRef: geofireRef.ref.child(NameFile.RTDB.RTDBPosts))
>>>>>>> 81e3ffada19361eaaec778ef2feb60eac936e988
        creatorUID = _creatorUID
        creatorUsername = _creatorUsername
        creatorProfileImage = _creatorProfileImage
        postID = _postID
        location = _location
        category = _category
        time = _time
        question = _question
        numReplies = _numReplies
        image = _image
        questionImageURL = nil
    }
    
    init(_creatorUID: String, _creatorUsername: String, _postID: String, _location : GeoPoint , _category: String, _time: Timestamp, _question: String, _numReplies: Int, _imageURL: URL?) {
        geofireRef = Database.database().reference()
        geoFire = GeoFire(firebaseRef: geofireRef.ref.child(NameFile.RTDB.RTDBPosts))
        creatorUID = _creatorUID
        creatorUsername = _creatorUsername
        postID = _postID
        location = _location
        category = _category
        time = _time
        question = _question
        numReplies = _numReplies
        questionImageURL = _imageURL
        image = nil
    }
    
    init() {
        geofireRef = Database.database().reference()
        geoFire = GeoFire(firebaseRef: geofireRef.ref.child(NameFile.RTDB.RTDBPosts))
        creatorUID = ""
        creatorUsername = ""
        creatorProfileImage = UIImage()
        postID = ""
<<<<<<< HEAD
        location = GeoPoint(latitude: 0, longitude: 0)
=======
        location = GeoPoint(latitude: 0.0, longitude: 0.0)
        // longitude = 0
        //  latitude = 0
>>>>>>> 81e3ffada19361eaaec778ef2feb60eac936e988
        category = ""
        time = Timestamp()
        question = ""
        numReplies = 0
<<<<<<< HEAD
        image = UIImage()
    }
    
    func pushToFirestore(){
        let postCollection: CollectionReference = Firestore.firestore().collection(NameFile.Firestore.posts)
=======
        image = nil
        questionImageURL = nil
    }
    
    func pushToFirestore(){
        //firebase references
        let postCollection: CollectionReference = Firestore.firestore().collection(NameFile.Firestore.FirestorePosts)
>>>>>>> 81e3ffada19361eaaec778ef2feb60eac936e988
        let imageStorage: StorageReference = Storage.storage().reference(withPath: NameFile.Firestore.images)
        
        let newDocument = postCollection.document()
        geoFire.setLocation(CLLocation(latitude: location.latitude, longitude: location.longitude), forKey: newDocument.documentID)
        //        if image != nil {
        //            print("image exists")
        //            imageStorage.child(NameFile.Firestore.images)/*.child(newDocument.documentID)*/.putData(UIImagePNGRepresentation(image!)!) { error in
        //                print("metadata shat")
        //                // You can also access to download URL after upload.
        //                imageStorage.child(NameFile.Firestore.images).downloadURL { (url, error) in
        //                    if url != nil {
        //                        print("setting data")
        //                        newDocument.setData([
        //                            NameFile.Firestore.creatorUID: self.creatorUID,
        //                            NameFile.Firestore.creatorUsername: self.creatorUsername,
        //                            NameFile.Firestore.postLongitude : self.location.longitude,
        //                            NameFile.Firestore.postLatitude : self.location.latitude,
        //                            NameFile.Firestore.postCategory: self.category,
        //                            NameFile.Firestore.postTime: self.time,
        //                            NameFile.Firestore.postQuestion: self.question,
        //                            NameFile.Firestore.postImageURL: url?.absoluteString
        //                            ])
        //
        //                        SVProgressHUD.dismiss()
        //                    }
        //                    else {
        //                        // Uh-oh, an error occurred!
        //                        print("you played your self")
        //                        print(error!)
        //                        return
        //                    }
        //                }
        //            }
        //        }
        //
        
        if let image = image{
            imageStorage.child(newDocument.documentID).putData(UIImagePNGRepresentation(image)!).observe(.success, handler: { (snapshot) in
                print("step 1")
                if let imageURL = snapshot.metadata?.downloadURL()?.absoluteString{
                    print("writing image data")
                    newDocument.setData([
                        NameFile.Firestore.creatorUID: self.creatorUID,
                        NameFile.Firestore.creatorUsername: self.creatorUsername,
                        NameFile.Firestore.postLongitude : self.location.longitude,
                        NameFile.Firestore.postLatitude : self.location.latitude,
                        NameFile.Firestore.postCategory: self.category,
                        NameFile.Firestore.postTime: self.time,
                        NameFile.Firestore.postQuestion: self.question,
                        NameFile.Firestore.postImageURL: imageURL
                        ])
                    self.questionImageURL = URL(string: imageURL)
                    SVProgressHUD.dismiss()
                }
            })
        }
        else{
            newDocument.setData([
                NameFile.Firestore.creatorUID: self.creatorUID,
                NameFile.Firestore.creatorUsername: self.creatorUsername,
                NameFile.Firestore.postLongitude : self.location.longitude,
                NameFile.Firestore.postLatitude : self.location.latitude,
                NameFile.Firestore.postCategory: self.category,
                NameFile.Firestore.postTime: self.time,
                NameFile.Firestore.postQuestion: self.question
                ])
            SVProgressHUD.dismiss()
            
        }
    }
    
}
