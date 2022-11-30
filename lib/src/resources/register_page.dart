import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/src/blocs/auth_bloc.dart';
import 'package:taxi_app/src/resources/dialog/msg_dialog.dart';
import 'package:taxi_app/src/resources/home.dart';
import 'package:taxi_app/src/resources/login_page.dart';

import 'dialog/loading_dialog.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  AuthBloc bloc = new AuthBloc();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  bool _showPass = true;

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.fromLTRB(40, 0, 40,0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset("assets/ic/ic_car_red.png"),
              Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 10),
                child: Text(
                  "Xin chào ",
                  style: TextStyle(color: Colors.black87,fontSize: 20),
                ),
              ),
              Text("Tạo tài khoản Taxi App để sử dụng",
                style: TextStyle(color: Colors.black87, fontSize: 13),
                  ),
              Padding(
                padding: const EdgeInsets.only(top: 50,bottom: 20,),
                child: StreamBuilder(
                  stream: bloc.nameStream,
                  builder: (context,snapshot) => TextField(
                    controller: _nameController,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  decoration: InputDecoration(
                      labelText: "Name",
                      errorText: snapshot.hasError ? snapshot.error.toString() : null,
                      prefixIcon: Container(
                        child: Image.asset("assets/ic/ic_user.png"),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                    ),
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: StreamBuilder(
                  stream: bloc.phoneStream,
                  builder: (context,snapshot) => TextField(
                  controller: _phoneController,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  decoration: InputDecoration(
                    errorText: snapshot.hasError ? snapshot.error.toString() : null,
                      labelText: "Phone number",
                      prefixIcon: Container(
                        child: Image.asset("assets/ic/ic_phone.png"),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      )),
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: StreamBuilder(
                  stream: bloc.emailStream,
                  builder: (context,snapshot) => TextField(
                  controller: _emailController,
                  style: TextStyle(
                      fontSize: 15, color: Colors.black),
                  decoration: InputDecoration(
                    errorText: snapshot.hasError ? snapshot.error.toString() : null,
                      labelText: "Email",
                      prefixIcon: Container(

                        child: Image.asset("assets/ic/ic_mail.png"),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      )),
                ),),
              ),
              Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  StreamBuilder(
                    stream: bloc.passStream,
                    builder: (context,snapshot) => TextField(
                      controller: _passController,
                      obscureText: _showPass,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                      decoration: InputDecoration(
                          errorText: snapshot.hasError ? snapshot.error.toString() : null,
                          labelText: "Password",
                          prefixIcon: Container(
                            child: Image.asset("assets/ic/ic_lock.png"),

                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          )),
                    ),),
                  GestureDetector(
                    onTap: showPass,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        _showPass ? "SHOW" : "HIDE",
                        style: TextStyle(color:Colors.blue, fontSize: 13,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                ],
              ),


              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text(
                      "Đăng kí",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      )),
                      overlayColor: MaterialStateProperty.all(Colors.pink),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: RichText(

                  text:  TextSpan(
                      text: "Already a User? ",
                      style: TextStyle(color: Colors.black87,fontSize: 13),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage()));
                          },
                          text: "Login now",
                          style: TextStyle(color: Colors.blue, fontSize: 13),
                        ),
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPressed() {
    var isValid = bloc.isValid(_emailController.text, _passController.text, _nameController.text, _phoneController.text);
    if(isValid){
      LoadingDialog.showLoadingDialog(context, "Loading...");
      
      bloc.signUp(_emailController.text, _passController.text,
          _phoneController.text, _nameController.text, (){
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => homePage()));
      },(msg){
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Sign-In", msg);

      });
    }
  }

  void showPass() {
    setState((){
      _showPass = !_showPass;
    });

  }
}
