import 'package:flutter/material.dart';

class MsgDialog{
  static showMsgDialog(BuildContext context, String title, String msg){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        TextButton( child: Text("OK"),
          onPressed: (){
          Navigator.of(context).pop(MsgDialog());
        })
      ],
    ));

}


}