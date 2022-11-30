import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taxi_app/src/firebase/fire_base_auth.dart';


class AuthBloc{

  var firAuth = FireAuth();
  StreamController _nameController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passController = new StreamController();
  StreamController _phoneController = new StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get phoneStream => _phoneController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;

  
  bool isValid( String email,String pass,String name,String phone){
    if(name == null  || name.trim().length == 0 || name.length == 0){
      _nameController.sink.addError("Tên không được để trống");
      return false;
    }
    _nameController.sink.add("name ok");
    if(phone.length == 0 || phone.trim().length == 0 || phone == null){
      _phoneController.sink.addError("hãy điền số điện thoại của bạn");
      return false;
    }
    _phoneController.add("phone ok");
    if(email.length == 0 || email ==null || email.trim().length == 0 || !email.contains("@") ||!email.contains(".com")){
      _emailController.sink.addError("Email có dạng abc@edf.com");
      return false;
    }
    _emailController.add("mail ok");

    if(pass.length <6 || pass == null){
      _passController.sink.addError("Mật khẩu tối thiểu 6 kí tự");
      return false;
    }
    _phoneController.add("pass ok");

    return true;
  }
  void signUp(String email,String pass, String phone,String name, Function onSuccess,Function(String) onRegisterError ){
    firAuth.signUp(email, pass, name, phone, onSuccess,onRegisterError,);

  }
  void signIn(String email,String pass,Function onSuccess,Function(String) onSignInError){
    firAuth.signIn(email, pass, onSuccess, onSignInError);
  }
  void dispose(){
      _nameController.close();
      _emailController.close();
      _phoneController.close();
      _passController.close();
  }

}