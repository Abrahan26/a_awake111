import 'package:newtotolist/pages/user_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newtotolist/HomePage.dart';
import 'package:newtotolist/main base.dart';  
import 'package:intl/intl.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'avenir'),
      home: UserPage(),
    );
  }
}

class user_page extends StatefulWidget{
  @override
  State<user_page> createState() => _UserPageState();
}

class _UserPageState extends State<user_page>{

  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerDescription = TextEditingController();
  
  @override  
  Widget build(BuildContext context) => Scaffold(

    appBar: AppBar(
      title: Text("Add User"),
    ),
    body: ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        TextField(
          controller: controllerName,
          decoration: decoration("Nombre"),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: controllerAge,
          decoration: decoration("Edad"),
          keyboardType: TextInputType.number,
        ),

        const SizedBox(height: 24),
          TextField(
          controller: controllerDescription,
          decoration: decoration("Descripción"),
        ),
       
        const SizedBox(height:32),
        ElevatedButton(
          child: Text('Crear'),
          onPressed: (){
            final user = User(
              name: controllerName.text,
              age: int.parse(controllerAge.text),
              description: controllerDescription.text
              );

            createdUser(user);

            Navigator.pop(context);
          },
        )


      ],
    ),
  );


InputDecoration decoration(String label) => InputDecoration(
  labelText: label,
  border: OutlineInputBorder(),

);

Future createdUser(User user) async {
  final docUser = FirebaseFirestore.instance.collection('Registro').doc();
  user.id = docUser.id;

  final json = user.toJson();
  await docUser.set(json);
}
}