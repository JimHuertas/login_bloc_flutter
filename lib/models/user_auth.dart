import 'package:bloc_flutter_login/models/user.dart' ;
import 'package:firebase_auth/firebase_auth.dart' as FBAuth;

class AuthRepository{
  final FBAuth.FirebaseAuth _fireAuth;

  AuthRepository({FBAuth.FirebaseAuth? firebaseAuth}) 
    : _fireAuth = firebaseAuth ?? FBAuth.FirebaseAuth.instance;


  var currentUser = User.empty; 
  Stream<User> get user{
    return _fireAuth.authStateChanges().map((firebaseuser){
      final user = (firebaseuser == null) ? User.empty : firebaseuser.toUser;
      currentUser = user;
      print(currentUser.email);
      return user;
    }); 
  }

  ///SINGUP method
  Future<void> singUp({required String email, required String password, required String name, required String number}) async{
    try {
      final res = await FBAuth.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
      final user = res.user;
      await user!.updateDisplayName(name);
      // await FBAuth.FirebaseAuth.instance.verifyPhoneNumber(
      //   phoneNumber: '+51 $number',
      //   verificationCompleted: (FBAuth.PhoneAuthCredential credential) async{
      //     FBAuth.UserCredential authresult =
      //       await _fireAuth.signInWithCredential(credential);
      //   },
      //   verificationFailed: (FBAuth.FirebaseAuthException e) {
      //     String error = e.code == 'invalid-phone-number'
      //       ? "Invalid number. Enter again."
      //       : "Can Not Login Now. Please try again.";
      //   },
      //   codeSent: (String verificationId, int? resendToken) {

      //   },
      //   codeAutoRetrievalTimeout: (String verificationId) {

      //   },
      // );

      

      print('si se registro');
    } on FBAuth.FirebaseAuthException catch (e){
      if(e.code == 'weak-password'){
        print('This password is too weak');
        throw Exception('This password is too weak');
      } else if(e.code == 'email-already-in-use'){
        print('This account already exist with same email');
        throw Exception('This account already exist with same email');
      }
    }
    catch (e) {
      print('error de logeo');
      throw Exception(e.toString());
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      print('paso la prueba del logeo');
    } catch (e) {
      print('no se que habra pasado, pero no se logeo');
      throw Exception(e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([_fireAuth.signOut()]);
    } catch (e) {
      print('deslogeo gaaa');
      throw Exception(e.toString());
    }
  }
}

extension on FBAuth.User{
  User get toUser{
    return User(id: uid, email: email, nombre: displayName, photo: photoURL, number: phoneNumber);
  }
}