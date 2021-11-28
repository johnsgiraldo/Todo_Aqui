
import 'package:flutter/material.dart';
import 'package:todo_aqui/Usuarios/GestionUsuario.dart';
import 'package:todo_aqui/Negocios/ShopList.dart';
import 'package:todo_aqui/Busqueda.dart';
import 'package:todo_aqui/Home.dart';
import 'package:todo_aqui/Negocios/RegistroNegocio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CambioPass extends StatefulWidget{
  @override
  CambioPassApp createState() => CambioPassApp();
}

class CambioPassApp extends State<CambioPass>{
  @override
  Widget build(BuildContext context){
    final firebase = FirebaseFirestore.instance;
    TextEditingController correo=TextEditingController();
    TextEditingController pass=TextEditingController();
    TextEditingController passNew=TextEditingController();

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
                    "Correo":correo.text,
                    "Telefono":cursor.get("Telefono"),
                    "Estado":true,
                    "Contraseña":passNew.text,
                  });
                  mensaje("Correcto", "Actualizacion Correcta");
                }
                catch(e){
                  print(e);
                  mensaje("Error", "No se logra Registrar el Usuario"+e.toString());
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
        title: Text("Cambio Contraseña"),
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
                    labelText: 'Contraseña actual',
                    hintText: 'Digite Contraseña actual'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 2),
              child: TextField(
                controller: passNew,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: 'Contraseña Nueva',
                    hintText: 'Digite Contraseña Nueva'),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: ElevatedButton(
                  onPressed: () {
                    validarDatos();
                    /*correo.clear();
                    pass.clear();
                    passNew.clear();*/
                    print('Presione el boton');
                  },
                  child: Text('Cambiar Contraseña'),
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