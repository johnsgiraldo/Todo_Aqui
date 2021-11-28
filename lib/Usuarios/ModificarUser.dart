import 'package:flutter/material.dart';
import 'package:todo_aqui/Busqueda.dart';
import 'package:todo_aqui/main.dart';
import 'package:todo_aqui/Negocios/ShopList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_aqui/Usuarios/GestionUsuario.dart';
import 'package:todo_aqui/Negocios/ShopList.dart';
import 'package:todo_aqui/Busqueda.dart';
import 'package:todo_aqui/Home.dart';
import 'package:todo_aqui/Negocios/RegistroNegocio.dart';



class ModificarUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ModificarUsuario());
  }
}

class ModificarUsuario extends StatefulWidget{
  @override
  ModificarUsuarioApp createState() => ModificarUsuarioApp();
}

class ModificarUsuarioApp extends State<ModificarUsuario> {
  final firebase = FirebaseFirestore.instance;
  String UserId="";
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController pass = TextEditingController();

  ModUsers() async{
    try{
      await firebase
          .collection("Usuarios")
          .doc(UserId)
          .set({
        "Nombre":nombre.text,
        "Correo":correo.text,
        "Telefono":telefono.text,
        "Estado":true,
        "Contraseña":pass.text,
      });
      mensaje("Correcto", "Registro Correcto");
    }
    catch(e){
      print(e);
      mensaje("Error", "No se logra Registrar el Usuario"+e.toString());
    }
  }

  validarDatos() async{
    try{
      CollectionReference ref=FirebaseFirestore.instance.collection("Usuarios");
      QuerySnapshot usuario=await ref.get();

      if(usuario.docs.length !=0){
        int flag=0;
        for(var cursor in usuario.docs){
          if(cursor.get("Correo")==correo.text){
            if(cursor.get("Contraseña")==pass.text){
              print("Usuario encontrado");
              flag=1;
              print(cursor.id);
              try{
                await firebase
                    .collection("Usuarios")
                    .doc(cursor.id);

                nombre.text=cursor.get("Nombre");
                telefono.text=cursor.get("Telefono");
                //pass.text=cursor.get("Contraseña");
                UserId=cursor.id;

              }
              catch(e){
                print(e);
                mensaje("Error", "No se logra encontrar el Usuario"+e.toString());
              }
            }


              /*Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Home()));*/
            }
        }
        if (flag==0){
          mensaje("Login","Usuario NO encontrado");
        }
      }else{
        print("Collección vacía");
      }
    }catch(e){

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
        title: Text("Modificar datos de Usuarios"),
        backgroundColor: Colors.teal[100],
      ),
      body: Container(
          child: Column(children: <Widget>[
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
                  child: Text('Traer Datos'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                )),
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
                padding: EdgeInsets.only(bottom: 200),
                child: ElevatedButton(
                  onPressed: () {

                    ModUsers();
                    nombre.clear();
                    correo.clear();
                    telefono.clear();
                    pass.clear();
                    print('Presione el boton');
                  },
                  child: Text('Modificar datos de Usuario'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                  ),
                )),
            botonSection,
          ])),
    );
  }

  void mensaje(String titulo,String mess ){
    showDialog(
        context:context,
        builder: (builcontext){
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: [
              RaisedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child:Text("Aceptar",
                    style:TextStyle(color:Colors.blueGrey)),
              ),
            ],
          ) ;
        }
    );
  }

}