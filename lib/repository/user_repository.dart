import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guess_score/model/custom_user.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("users");

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<bool> isSignedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  User getCurrentUser() {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  Future<CustomUser> getCurrentUserAndConvertToCustomUser() async {
    CustomUser cuser = await convertGoogleUsertoCustomUser(_firebaseAuth.currentUser);
    return cuser;
  }

  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<CustomUser> convertGoogleUsertoCustomUser(User user) async {
    CustomUser cuser = CustomUser.withoutPoint(
        uid: user.uid,
        displayName: user.displayName,
        profileImage: user.photoURL,
        email: user.email);
    DocumentSnapshot doc = await checkUserIsExistsOnFirestore(cuser);
    if (doc.exists)
      cuser.point = doc.get("point");
    else
      await createUserOnFirestore(cuser);
    return cuser;
  }

  Future<DocumentSnapshot> checkUserIsExistsOnFirestore(CustomUser user) async {
    //firestoreda kullanıcı var mı? varsa true
    DocumentSnapshot doc = await usersCollection.doc(user.uid).get();
    return doc;
  }
  Future<CustomUser> findCustomUserByUidOnFirestore(CustomUser user) async {
    DocumentSnapshot doc = await usersCollection.doc(user.uid).get();
    user.point = doc.get("point");
    return user;
  }
  Future<CustomUser> createUserOnFirestore(CustomUser user) async {
    await usersCollection
        .doc(user.uid)
        .set({'point': 100}).then((value) => user.point = 100);
    return user;
  }
}
