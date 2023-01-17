import 'package:municipal_track/code/QueryChat/helper/helper_function.dart';
import 'package:municipal_track/code/QueryChat/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// login
  // Future loginWithUserNameWithPhonenumber(String phoneNumber, String password) async {
  //   try {
  //     User user = (await firebaseAuth.signInWithCredential(
  //         ))
  //         .user!;
  //
  //     if (user != null) {
  //       return true;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   }
  // }

  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// register
  // Future registerUserNameWithPhonenumber(
  //     String fullName, String phoneNumber, String password) async{
  //   try {
  //     User user = (await firebaseAuth.s)
  //   } on FirebaseAuthException catch (e){
  //     return e.message;
  //   }
  //
  // }

  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        // call our database service to update the user data.
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // signout
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
