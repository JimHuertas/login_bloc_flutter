import 'package:bloc_flutter_login/models/user.dart' ;
import 'package:firebase_auth/firebase_auth.dart' as FBAuth;

///class [AuthRepository], working as a mediator beetween [UserBloc] model
///and firebase, 
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
      // await _verificationNumber(number: number);
    } on FBAuth.FirebaseAuthException catch (e){
      if(e.code == 'weak-password'){
        throw Exception('This password is too weak');
      } else if(e.code == 'email-already-in-use'){
        throw Exception('This account already exist with same email');
      }
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> _verificationNumber({required String number}) async{
    String? result;
    final _authPhone = FBAuth.FirebaseAuth.instance;
    try {
      await _authPhone.verifyPhoneNumber(
        phoneNumber: '+51 $number',
        timeout: const Duration(seconds: 30),
        verificationCompleted: (FBAuth.PhoneAuthCredential credential) async{
          FBAuth.UserCredential authresult =
            await _fireAuth.signInWithCredential(credential);
        },
        verificationFailed: (FBAuth.FirebaseAuthException e) {
          result = e.code == 'invalid-phone-number'
            ? "Invalid number. Enter again."
            : "Can Not Login Now. Please try again.";
        },
        codeSent: (String verificationId, int? resendToken) async{
          String smsCode = 'xxxx';
          // Create a PhoneAuthCredential with the code
          FBAuth.PhoneAuthCredential credential 
          = FBAuth.PhoneAuthProvider.credential(
            verificationId: verificationId, 
            smsCode: smsCode);
          // Sign the user in (or link) with the credential
          await _authPhone.signInWithCredential(credential);
          result = "verified";
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          result = "timeout";
        },
      );
      return result!;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([_fireAuth.signOut()]);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

extension on FBAuth.User{
  User get toUser{
    return User(id: uid, email: email, nombre: displayName, photo: photoURL, number: phoneNumber);
  }
}