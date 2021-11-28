import 'package:flutter/material.dart';
import 'package:todo_aqui/Busqueda.dart';
import 'package:todo_aqui/Home.dart';
import 'package:todo_aqui/Negocios/ShopList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_aqui/Usuarios/GestionUsuario.dart';
import 'package:todo_aqui/Negocios/ShopList.dart';
import 'package:todo_aqui/Busqueda.dart';
import 'package:todo_aqui/main.dart';
import 'package:todo_aqui/Negocios/RegistroNegocio.dart';



class RegistroUsuar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: RegistroUsuario());
  }
}

class RegistroUsuario extends StatefulWidget{
  @override
  RegistroUsuarioApp createState() => RegistroUsuarioApp();
}

class RegistroUsuarioApp extends State<RegistroUsuario> {
  final firebase = FirebaseFirestore.instance;
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController contrasena = TextEditingController();

  registroUsers() async{
    try{
      await firebase
          .collection("Usuarios")
          .doc()
          .set({
        "Nombre":nombre.text,
        "Correo":correo.text,
        "Telefono":telefono.text,
        "Estado":true,
        "Contraseña":contrasena.text,
      });
      mensaje("Correcto", "Registro Correcto");
    }
    catch(e){
      print(e);
      mensaje("Error", "No se logra Registrar el Usuario"+e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    //*********Seccion de Botones *************
    Widget botonSection = Container(
      color: Colors.teal[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
              padding: EdgeInsets.only(),
              child: IconButton(
                icon: const Icon(Icons.home),
                color: Colors.teal,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Home()));
                  print('Presione el boton');
                },
              )),
          Padding(
              padding: EdgeInsets.only(),
              child: IconButton(
                icon: const Icon(Icons.find_in_page),
                color: Colors.teal,
                onPressed: () {
                  print('Presione el boton');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => busqueda()));
                },
              )),
          Padding(
              padding: EdgeInsets.only(),
              child: IconButton(
                icon: const Icon(Icons.store),
                color: Colors.teal,
                onPressed: () {
                  print('Presione el boton');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ShopList()));
                },
              )),
          Padding(
              padding: EdgeInsets.only(),
              child: IconButton(
                icon: const Icon(Icons.add_business_rounded),
                color: Colors.teal,
                onPressed: () {
                  print('Presione el boton');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Registro()));
                },
              )),
          Padding(
              padding: EdgeInsets.only(),
              child: IconButton(
                icon: const Icon(Icons.supervised_user_circle),
                color: Colors.teal,
                onPressed: () {
                  print('Presione el boton');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => GestionUsuario()));
                },
              )),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text("Registro de Usuarios"),
        backgroundColor: Colors.teal[100],
      ),
      body: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 2),
              child: TextField(
                controller: nombre,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: 'Nombre',
                    hintText: 'Digite Nombre'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 2),
              child: TextField(
                controller: correo,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: 'Correo',
                    hintText: 'Digite Correo'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 2),
              child: TextField(
                controller: telefono,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: 'Telefono',
                    hintText: 'Digite Telefono'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 2),
              child: TextField(
                controller: contrasena,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: 'Contraseña',
                    hintText: 'Digite Contraseña'),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 260),
                child: ElevatedButton(
                  onPressed: () {

                    registroUsers();
                    nombre.clear();
                    correo.clear();
                    telefono.clear();
                    contrasena.clear();
                    print('Presione el boton');
                  },
                  child: Text('Registrar Usuario'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                )),
            botonSection,
          ])),
    );
  }
  void mensaje(String titulo,String mess){
    showDialog(context: context, builder: (builcontex){
      return AlertDialog(
        title: Text(titulo),
        content: Text(mess),
        actions: [
          RaisedButton(onPressed: (){
            Navigator.of(context).pop();
          },
            child: Text("Aceptar",
              style: TextStyle(color:Colors.teal),),
          ),
        ],
      );
    });
  }
}