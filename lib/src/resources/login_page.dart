import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/src/app.dart';
import 'package:taxi_app/src/blocs/auth_bloc.dart';
import 'package:taxi_app/src/resources/dialog/loading_dialog.dart';
import 'package:taxi_app/src/resources/dialog/msg_dialog.dart';
import 'package:taxi_app/src/resources/home.dart';
import 'package:taxi_app/src/resources/register_page.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  bool _showPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 85,
              ),
              Image.asset("assets/ic/ic_car_green.png"),

              // Image.asset("ic_car_red.png"),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  "Xin chào",
                  style: TextStyle(fontSize: 22, color: Colors.black87),
                ),
              ),
              Text(
                "Đăng nhập để sử dụng Taxi APP",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100,bottom: 20,),
                child: Container(
                  height: 45,
                  width:double.infinity,
                  child: TextField(
                    controller: _emailController,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Container(
                          width: 50,
                          child: Image.asset("assets/ic/ic_mail.png"),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white30, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        )),
                  ),

                ),
              ),
              Container(
                height: 45,
                width:double.infinity,
                child:  Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    TextField(
                      controller: _passController,
                      obscureText: _showPass,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Container(
                            child: Image.asset("assets/ic/ic_lock.png"),

                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          )),
                    ),
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
              ),
              Container(
                // constraints: BoxConstraints.loose(Size(double.infinity,30)),
                padding: EdgeInsets.only(top: 20),
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  "Forgot password ? ",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text(
                      "Đăng nhập",
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
                padding: const EdgeInsets.only(bottom: 40),
                child: RichText(

                  text:  TextSpan(
                  text: "New user? ",
                  style: TextStyle(color: Colors.black87,fontSize: 13),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                        },
                        text: "Sign up for a new account",
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
    String email = _emailController.text;
    String pass = _passController.text;
    var authBloc = MyApp.of(context)?.authBloc;
    LoadingDialog.showLoadingDialog(context, "Loading...");
    authBloc?.signIn(email, pass, (){
      LoadingDialog.hideLoadingDialog(context);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => homePage()));
    }, (msg){
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Sign-In", msg);
    });



  }

  void showPass() {
    setState((){
      _showPass = !_showPass;
    });
  }
}
