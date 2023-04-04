import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      icon: const Icon(Icons.error,color: Colors.red,),
      title: const Text("an Error occurred"),
      content: Text(text),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child:const Text("Ok"))
      ],
    );
  });
}