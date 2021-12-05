
import 'package:flutter/material.dart';
import 'package:todo_aqui/Usuarios/Login.dart';
import 'package:todo_aqui/Usuarios/ModificarUser.dart';
import 'RegistroUsuario.dart';
import 'Login.dart';
import 'package:todo_aqui/Negocios/RegistroNegocio.dart';
import 'package:todo_aqui/Usuarios/GestionUsuario.dart';
import 'package:todo_aqui/Negocios/ShopList.dart';
import 'package:todo_aqui/Busqueda.dart';
import 'package:todo_aqui/Home.dart';
import 'CambioPass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ModificarUser.dart';

class GestionUsuario extends StatefulWidget{
  @override
  GestionUsuarioApp createState() => GestionUsuarioApp();
}

class GestionUsuarioApp extends State<GestionUsuario>{
  final firebase = FirebaseFirestore.instance;
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
              flag=1;
              print(cursor.id);

              try{
                await firebase
                    .collection("Usuarios")
                    .doc(cursor.id)
                    .set({
                  "Nombre":cursor.get("Nombre"),
                  "Correo":cursor.get("Correo"),
                  "Telefono":cursor.get("Telefono"),
                  "Estado":false,
                  "Contraseña":cursor.get("Contraseña"),
                });
                mensaje("Correcto", "Se ha dado de baja al usuario");
              }
              catch(e){
                print(e);
                mensaje("Error", "No se logra encontrar el Usuario"+e.toString());
              }

              /*Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Home()));*/
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
          /*Padding(
              padding: EdgeInsets.only(),
              child: IconButton(
                icon: const Icon(Icons.find_in_page),
                color: Colors.teal,
                onPressed: () {
                  print('Presione el boton');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => busqueda()));
                },
              )),*/
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
        title: Text("Gestion de Usuario"),
        backgroundColor: Colors.teal[100],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 5,top: 40,right: 20,bottom: 0),
              child: Center(
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => RegistroUsuar()));
                },
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 45),primary: Colors.teal),
                  child: Text("Registro Usuario"),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 5,top: 10,right: 20,bottom: 0),
              child: Center(
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CambioPass()));
                },
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 45),primary: Colors.teal),
                  child: Text("Cambio Contraseña"),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 5,top: 10,right: 20,bottom: 0),
              child: Center(
                child: ElevatedButton(onPressed: (){
                  inactivar("Inactivar", "Desea darse de baja");
                },
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 45),primary: Colors.teal),
                  child: Text("Darse de baja"),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 5,top: 10,right: 20,bottom: 0),
              child: Center(
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ModificarUser()));
                },
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 45),primary: Colors.teal),
                  child: Text("Modificar Usuario"),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 5,top: 10,right: 20,bottom: 330),
              child: Center(
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Login()));
                },
                  style: ElevatedButton.styleFrom(minimumSize: Size(200, 45),primary: Colors.teal),
                  child: Text("Login"),
                ),
              ),
            ),
            botonSection,
          ],
        ),
      ),
    );
  }

  void inactivar(String titulo,String mess){
    showDialog(context: context, builder: (builcontex){
      return AlertDialog(
        title: Text(titulo),
        content: Text(mess),
        actions: [
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
            padding: EdgeInsets.only(left: 25, top: 5, right: 25, bottom: 2),
            child: TextField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  labelText: 'Contraseña',
                  hintText: 'Digite la contraseña'),
            ),
          ),
          RaisedButton(onPressed: (){
            validarDatos();
            //Navigator.of(context).pop();
          },
            child: Text("Aceptar",
              style: TextStyle(color:Colors.teal),),
          ),
          RaisedButton(onPressed: (){
            Navigator.of(context).pop();
          },
            child: Text("Cancelar",
              style: TextStyle(color:Colors.teal),),
          ),
        ],
      );
    });
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