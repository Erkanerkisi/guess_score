import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guess_score/model/custom_user.dart';

class UserRepository{

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<bool> isSignedIn() async {
   return _firebaseAuth.currentUser != null;
  }

  User getUser() {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut()
    ]);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  CustomUser convertGoogleUsertoCustomUser(User user){
    return CustomUser.withoutPoint(
        uid: user.uid,
        displayName: user.displayName,
        profileImage: user.photoURL,
        email: user.email);
    //google auth olduktan sonra user objesine çevir
  }
  checkUserIsExists(CustomUser user){
    //firestoreda kullanıcı var mı? varsa true
  }
  createUser(){
    //user firestoreda yoksa
    //firestore user creation with data
  }
}