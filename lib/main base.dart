import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newtotolist/HomePage.dart';
import 'package:newtotolist/pages/user_page.dart';
import 'package:intl/intl.dart';
import 'package:newtotolist/main base.dart';


class Myapp123 extends StatelessWidget {
  const Myapp123({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
          brightness: Brightness.light,
          primaryColor: Color.fromARGB(255, 243, 182, 15),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
              .copyWith(secondary: Color.fromARGB(255, 243, 182, 15))),
          home: const MyHomePage(title: 'AWAKE'),
          
          
    );
    
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  final controller = TextEditingController();


@override
Widget build(BuildContext context) => Scaffold(

    appBar: AppBar(
      title: Text('All users'),
    ),  
      body: FutureBuilder<User?>(
        future: readUser(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            final user = snapshot.data;

            return user == null
              ? Center(child: Text('No User'))
              : buildUser(user); 
          } else { 
            return Center(child: CircularProgressIndicator());
          }

        }),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute
        (builder: (context) => user_page(),
        ));
      },
    ),

);

Widget buildUser (User user) => ListTile (
    leading: CircleAvatar( child: Text('${user.id}')),
    title : Text(user.name),
    subtitle: Text (user.description)
    ,);



Stream<List<User>>readUsers() => FirebaseFirestore.instance.collection('Registro')
                                                            .snapshots()
                                                            .map((snapshot) =>
                                                              snapshot.docs.map((doc)=> User.fromJson (doc.data())) .toList());

  Future<User?> readUser() async{
    final docUser = FirebaseFirestore.instance.collection('Registro').doc('my-id');
    final snapshot = await docUser.get();

    if (snapshot.exists){
      return User.fromJson(snapshot.data()!);
    }
  }


Future createdUser({required String name}) async {
  final docUser = FirebaseFirestore.instance.collection('Registro').doc();

  final user = User(
    id: docUser.id,
    name: name,
    age: 21,
    description: 'tarea de inglés',
  );
  final json = user.toJson();

  await docUser.set(json);
}
}
class User{
  String id;
  final String name;
  final int age;
  final String description;

    User({
      this.id = "",
      required this.name,
      required this.age,
      required this.description,
    });

    Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "age": age,
      "description": description,
    };

    static User fromJson(Map<String, dynamic>json) => User (
      id: json ['id'],
      name: json['name'],
      age: json['age'],
      description: json['description'],
    );
}

