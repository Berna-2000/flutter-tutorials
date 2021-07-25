import '../common/packages.dart';
import '../models/user.dart';

class AuthenticationMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserClass defaultUser = new UserClass(userId: "00000");

  //Receives a User object and returns only the User ID
  UserClass _userFromFirebaseUser(User user){
    return UserClass(userId: user.uid);
  }

  //Auth change user stream (UserClass ni cya sauna)
  Stream<User?> get user{
    return _auth.authStateChanges();
  }

  //Sign in With Email and Password
  Future signinWithEmailandPassword(String email, String password) async { 
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      // User firebaseUser = _auth.currentUser;
      User? firebaseUser = result.user;
      return firebaseUser;
      // return _userFromFirebaseUser(firebaseUser);
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future getCurrentUser() async {
    return _auth.currentUser;
  }

  Future signOut() async {
    try{
      await _auth.signOut();
      return null;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future resetPassword(String email)async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }

  //Send Verification Email
  Future verifyEmail() async {
    User? user = _auth.currentUser;
    try{
      if (!(user!.emailVerified)) {
        await user.sendEmailVerification();
      }
    }catch(e){
      print(e.toString());
    }
  }

  //Check if email is verified
  Future <bool> checkVerfiedEmail() async{
    User? user = _auth.currentUser;
    await user!.reload();
    bool output = user.emailVerified;
    print(output);
    if(output == true){
      return true;
    }else{
      return false;
    }
  }

  //Sign up with Custom Fields
  Future signupWithEmailAndPassword(String email, String password) async{
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      // User firebaseUser = result.user;
      // return _userFromFirebaseUser(firebaseUser);
      User? firebaseUser = result.user;   
      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null;
    }catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Update User's Profile
  Future updateProfile(String username, String photo) async {
    User? user = _auth.currentUser;
    try{
      await user?.updateDisplayName(username);
      await user?.updatePhotoURL(photo);
      // await user.updateProfile(displayName: username, photoURL: photo).then((value) => print(photo));
    }catch(e){
      print(e.toString());
    }
  }

}
