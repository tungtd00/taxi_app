
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
class FireAuth{

   FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
   void signUp(String email, String pass , String name, String phone,
       Function onSuccces,Function(String) onRegisterError){
     _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass).
     then((user) {
       print(user);
       _createUser(user.user!.uid, name, phone, onSuccces,onRegisterError);
     }).catchError((err){
       print("err: "+ err.toString());
       _onSignUpErr(err.code,onRegisterError);
     });

   }
   _createUser(String userId, String name, String phone,
       Function onSuccces, Function(String) onRegisterError){
     var user = {
       "name" : name,
       "phone" : phone
     };
     var ref = FirebaseDatabase.instance.ref().child("users");
     ref.child(userId).set(user).then((user){
       onSuccces();
     }).catchError((err){
       onRegisterError("Sign fail, please try again");
     });

   }
   void signIn(String email, String pass,Function onSuccess,
       Function(String) onSignInError ){
     _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass).then((user){
       print("sign in success");
       onSuccess();
     }).catchError((err){
       onSignInError("Đăng nhập thất bại, vui lòng thử lại sau");
     });
   }



}


void _onSignUpErr(code,Function(String) onRegisterError) {
  switch(code){
    case "ERROR_INVALID_EMAIL":
    case "ERROR_INVALID_CREDENTIAL":
      onRegisterError("Invalid email");
      break;
    case "ERROR_EMAIL_ALREADY_IN_USE":
      onRegisterError("Email has existed");
      break;
    case "ERROR_WEAK_PASSWORD":
      onRegisterError("The password is not strong enough");
      break;
    default:
      onRegisterError("SignUp fail, please try again");
      break;
  }

}