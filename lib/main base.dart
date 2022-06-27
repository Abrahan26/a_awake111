import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Myapp123 extends StatelessWidget {
  const Myapp123({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.cyan)),
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
  String activityName = '',
      activityCode = '',
      activityDescripcion = '',
      activityFecha = '';

  getactivityName(name) {
    activityName = name;
  }

  getactivityCode(id) {
    activityCode = id;
  }

  getactivityDescripcion(descripcion) {
    activityDescripcion = descripcion;
  }

  getactivityFecha(fecha) {
    activityFecha = fecha;
  }

  createData() {
    print("created");

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("USERS").doc(activityCode);

    documentReference
        .set(
          {
            "activityCode": activityCode,
            "activityName": activityName,
            "activityDescripcion": activityDescripcion,
            "activityFecha ": activityFecha
          },
          SetOptions(merge: false),
        )
        .catchError((error) => print("Failed to merge data: $error"))
        .whenComplete(() {
          print("Actividad con nombre $activityName creado");
        });
  }

  ReadData() {
    print("Lectura");

    FirebaseFirestore.instance
        .collection('USERS')
        .doc(activityCode)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        print('Document data: ${data["activityCode"]}');

        AlertDialog alerta = AlertDialog( 
          title: const Text('LECTURA DE ACTIVIDAD'),
          content: Column(
            children: [
              Text('Nombre: ${data["activityName"]}'),
              Text('descripcion: ${data["activityDescripcion"]}'),
              Text('Codigo: ${data["activityCode"]}'),
              Text('Fecha: ${data["activityFecha"]}'),
            ],
          ),
        );
        showDialog(context: context, builder: (BuildContext context) => alerta);
      } else {
        AlertDialog alerta2 = const AlertDialog(
          title: Text('NO EXISTE DATOS'),
          content: Text("VEREFIQUE SU INFORMACIÓN"),
        );
        showDialog(
            context: context, builder: (BuildContext context) => alerta2);
      }
    });
  }

  UpdateData() {
    print("Modificación");

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("USERS").doc(activityCode);

    documentReference
        .update({
          "activityCode": activityCode,
          "activityName ": activityName,
          "activityDescripcion": activityDescripcion,
          "activityFecha": activityFecha
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  DeleteData() {
    print("Eliminar");

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("USERS").doc(activityCode);

    documentReference
        .delete()
        .then((value) => print("Actividad deleted"))
        .catchError((error) => print("Failed to delete actividad: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Nombre",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  onChanged: (String name) {
                    getactivityName(name);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Codigo de actividad",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  onChanged: (String id) {
                    getactivityCode(id);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "descripcion",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  onChanged: (String descripcion) {
                    getactivityDescripcion(descripcion);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "fecha",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  onChanged: (String fecha) {
                    getactivityFecha(fecha);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      createData();
                    },
                    child: const Text("Create"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        textStyle: const TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ReadData();
                    },
                    child: const Text(
                      "Read",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      textStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      UpdateData();
                    },
                    child: const Text("Update"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        textStyle: const TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      DeleteData();
                    },
                    child: const Text("Delete"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        textStyle: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: const [
                    Expanded(
                        child: Text(
                      "Nombre",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    Expanded(
                        child: Text("Código",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text("descripcion",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(
                        child: Text("fecha",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),

       /*       StreamBuilder(
                stream:
                    FirebaseFirestore.instance
                    .collection("USERS")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return ListView(
                    children: snapshot.data!.docs.map((USERS) {
                      return Center(
                        child: ListTile(
                          title: Text(USERS['activityName']),
                        ),
                      );
                    }).toList(),
                  );
                },
              )*/
            ],
          ),
        ),
      ),
    );
  }
}