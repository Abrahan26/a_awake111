  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
  import 'package:newtotolist/ModeloUsuarios.dart';
  import 'package:firebase_auth/firebase_auth.dart';

  class register extends StatefulWidget {
    const register({Key? key}) : super(key: key);

    @override
    State<register> createState() => _registerState();
  }

  class _registerState extends State<register> {

    
    final TextEditingController _emailcontroller = TextEditingController();
    final TextEditingController _nombrecontroller = TextEditingController();
    final TextEditingController _contrasenacontroller = TextEditingController();

    Future signUp(String email, String password, ) async{
    
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _contrasenacontroller.text.trim(),

          );
          
        
          //agrega el usuario

            Firestoreposteo();

      
    }

    Future Firestoreposteo() async {

      
      User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      ModeloUsuarios modeloUsuarios = ModeloUsuarios();

      modeloUsuarios.nombre = _nombrecontroller.text;
      modeloUsuarios.contrasena = _contrasenacontroller.text;
      modeloUsuarios.correo = _emailcontroller.text;
      modeloUsuarios.uid = user!.uid;

      await firebaseFirestore
      .collection("USERS")
      .doc(_nombrecontroller.text)
      .set(modeloUsuarios.toMap());
      
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: _nombrecontroller,
                    decoration: InputDecoration(
                      labelText: 'Usuario'
                    ),
                  ),),

                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                      labelText: 'Correo'
                    ),
                  ),),
                  SizedBox(height: 10,),

                  Padding(padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: _contrasenacontroller,
                    decoration: InputDecoration(
                      labelText: 'Contraseña'
                    ),
                  ),),

                  RaisedButton(
                    onPressed: (){
                      signUp(_emailcontroller.text, _contrasenacontroller.text);
                    },
                    child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('CREAR CUENTA'),), )
                ],
              ),
            ),
          ) 
        ),
      );
    }
  }