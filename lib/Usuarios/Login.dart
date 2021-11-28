
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_aqui/Home.dart';
import 'RegistroUsuario.dart';
import 'package:todo_aqui/Usuarios/GestionUsuario.dart';
import 'package:todo_aqui/Negocios/ShopList.dart';
import 'package:todo_aqui/Busqueda.dart';
import 'package:todo_aqui/Negocios/RegistroNegocio.dart';

class Login extends StatefulWidget{
  @override
  LoginApp createState() => LoginApp();
}

class LoginApp extends State<Login>{
  TextEditingController correo=TextEditingController();
  TextEditingController pass=TextEditingController();

  validarDatos() async{
    try{
      CollectionReference ref=FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot usuario=await ref.get();

      if(usuario.docs.length !=0){
        int flag=0;
        for(var cursor in usuario.docs){
          //print(cursor.get("Correo"));
          if(cursor.get("Correo")==correo.text){
            //print("Correo encontrado");
            if(cursor.get("Contraseña")==pass.text){
              print("Usuario encontrado");
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => Home()));
            }
          }
        }
        if(flag==0){
          print("Correo NO encontrado");
        }
      }else{
        print("Coleccion vacia");
      }
    }catch(e){

    }
  }


  @override
  Widget build(BuildContext context){

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
        title: Text("Ingrese Usuario Registrado"),
        backgroundColor: Colors.teal[100],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(1),
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                child: Image.asset('image/logo.png'),
              ),
            ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, top: 5, right: 25, bottom: 2),
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
                controller: pass,
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
                padding: EdgeInsets.only(),
                child: ElevatedButton(
                  onPressed: () {
                    validarDatos();
                    print('Presione el boton');
                  },
                  child: Text('Entrar'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegistroUsuar()));
                    print('Presione el boton');
                  },
                  child: Text('Crear cuenta'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                )),
            botonSection,
          ],
        ),
      ),
    );
  }
}