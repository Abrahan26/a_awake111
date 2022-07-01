import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newtotolist/LoginPage.dart';
import 'package:newtotolist/ModeloUsuarios.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newtotolist/Onboarding.dart';

import 'HomePage.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {

ModeloUsuarios modeloUsuarios= ModeloUsuarios();



  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _nombrecontroller = TextEditingController();
  final TextEditingController _contrasenacontroller = TextEditingController();

  Future signUp(
    String email,
    String password,
  ) async {
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
        .collection("Usuarios")
        .doc(user.uid)
        .set(modeloUsuarios.toMap());
    //
    openOnboardinPage();
  }
  bool isHiddenPassword =true ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 225, 195),
      appBar: AppBar(
        backgroundColor: Color(0xfff96060),
        elevation: 0,
        title: Text(
          "",
          style: TextStyle(fontSize: 25),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
           onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Onboarding()));
          },
        ),
      ),

      

      body: Center(
        child: SafeArea(
            child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                Image(image: AssetImage('asset/image/aawake.png')),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: _nombrecontroller,
                    decoration: InputDecoration(labelText: 'Usuario', prefixIcon:  Icon(Icons.account_circle)),
                  ),
                ),  
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: _emailcontroller,
                    decoration: InputDecoration(labelText: 'Correo', prefixIcon: Icon(Icons.email) ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    obscureText: isHiddenPassword,
                    controller: _contrasenacontroller,
                    decoration: InputDecoration(labelText: 'Contraseña',
                                prefixIcon:  Icon(Icons.lock) ,
                                suffixIcon: InkWell(
                                  onTap:_togglePassword,
                                  child: Icon(Icons.visibility,))),
                    
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    signUp(_emailcontroller.text, _contrasenacontroller.text);
                  },
                  color: Colors.orange,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('CREAR CUENTA'),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }  void _togglePassword(){
    if(isHiddenPassword == true){
      isHiddenPassword =false;
    } else {
      isHiddenPassword = true;
    }
    setState(() {
      
    });
  }




  openOnboardinPage() {
    Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
