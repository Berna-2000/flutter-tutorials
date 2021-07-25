
/* 
   PLACE THIS IN THE CONTROLLER FOLDER IN LIB

   Not everything in the user controller is for the sign up of the users. 
   Some are used for retrieving the users from the database so that they can be displayed to the front end. 
*/

import '../common/packages.dart'; //contains the firebase core, auth, and cloud firestore
import '../models/appUsers.dart'; // our model

class UserController {
  CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  createUser(String uid, String emailAddress, String username){
    return users.doc(uid).set({
      'username': username,
      'emailAddress': emailAddress,
      'deleted': false,
    });
  }


  /* 
     If you can see, it returns a list (because it says .toList() 
     of the documents in the "Users" collection from the Firestore database ) 
  */
  List<AppUser>? _usersList(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return AppUser(
          username: (doc.data() as dynamic)['username'],
          emailAddress: (doc.data() as dynamic)['emailAddress'],
          uid: doc.id,
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /* 
     This method places or maps the usersList obtained from the method above in a Stream,
     so that the flow of data from backend (Point A) to frontend (point B) is continuous. 

     Imagine a flowing water (that is your stream) and then putting a paper boat. You will 
     see that your paper boat flows in the direction of your stream. The same thing is happening
     with your data (<List<AppUser>>)
  */
  Stream<List<AppUser>?>? get retrieveAllUsers {
    try {
      return users.snapshots().map(_usersList);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /*
     This is the method used to retrieve information of the user of a specified detail.
     For example, if I searched for the email "mbferolin@gmail.com" in the frontend,
     it will query for the users whose email address is "mbferolin@gmail.com"

     MySQL translation:
     "SELECT * FROM users WHERE emailAddress = "+emailAddress+";"
  */
  Future<QuerySnapshot?> retrieveUserofChatroom(String emailAddress) async {
    try{
      return users
        .where("emailAddress", isEqualTo: emailAddress)
        .get();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  /*
     Not included in your backend, so you may delete this, since you won't be using Google Signin
   */
  Future<bool?> doesGoogleUserExist(String emailAddress) async {
    try{
      final result = await users.where("emailAddress", isEqualTo: emailAddress).get();
      if(result.docs.isEmpty){
        print("This user has not existed yet");
        return false;
      }else{
        print("This user is already in the database");
        return true;
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  /*
     So, this method is similar to the function retrieveUserofChatroom(). 
     The only difference is, instead of returning Querysnapshots (or documents),
     Again, it places the QuerySnapshots in a stream.
   */
  Future<Stream<QuerySnapshot>?> getUserbyEmail(String emailAddress) async {
    try{
      return users
      .where("emailAddress", isEqualTo: emailAddress)
      .snapshots();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  /* 
     I don't think you'll be using this method as well since you won't be needing the displayPhoto.
     If you really need a displayPhoto,
     just instantiate a FirebaseAuth through the method FirebaseAuth.instance, and then get your current user.

     _auth = FirebaseAuth.instance;
     current_user = _auth.currentUser;
     current_user.photoURL;

  */
  Future<String?> retrieveUserInformationFromUsername(String username) async {
    try{
      dynamic result = await users
        .where("username", isEqualTo: username)
        .get();
      return result.docs.first['displayPhoto'];
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}
