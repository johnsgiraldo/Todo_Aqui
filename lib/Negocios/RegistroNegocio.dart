
import 'package:flutter/material.dart';
import 'package:todo_aqui/Busqueda.dart';
import 'package:todo_aqui/Home.dart';
import 'package:todo_aqui/Negocios/ShopList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_aqui/Usuarios/GestionUsuario.dart';



class Registro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: RegistroNegocio());
  }
}

class RegistroNegocio extends StatefulWidget{
  @override
  RegistroNegocioApp createState() => RegistroNegocioApp();
}

class RegistroNegocioApp extends State<RegistroNegocio> {
  final firebase = FirebaseFirestore.instance;
  TextEditingController Nombre = TextEditingController();
  TextEditingController Direccion = TextEditingController();
  TextEditingController Telefono = TextEditingController();
  TextEditingController Horario = TextEditingController();
  TextEditingController Maps = TextEditingController();
  TextEditingController Servicio = TextEditingController();
  TextEditingController Tipo = TextEditingController();
  TextEditingController Web = TextEditingController();
  TextEditingController ProductoServicio = TextEditingController();
  TextEditingController Imagen = TextEditingController();

  registroTienda() async{
    try{
      await firebase
          .collection("Negocios")
          .doc()
          .set({
        "Nombre":Nombre.text,
        "Direccion":Direccion.text,
        "Telefono":Telefono.text,
        "Horario":Horario.text,
        "Maps":Maps.text,
        "Servicio": Servicio.text,
        "Tipo": Tipo.text,
        "Web":Web.text,
        "ProductoServicio":ProductoServicio.text,
        "Imagen":Imagen.text,
      });
    }
    catch(e){
      print(e);
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text("Creacion de Negocios"),
        backgroundColor: Colors.teal[100],
      ),
       body: Container(
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 25, top: 0.5, right: 25, bottom: 1),
                child: TextField(
                  controller: Nombre,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'Nombre del Negocio',
                      hintText: 'Palabra clave de la busqueda'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, top: 0.5, right: 25, bottom: 1),
                child: TextField(
                  controller: Direccion,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'Direccion',
                      hintText: 'Palabra clave de la busqueda'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, top: 0.5, right: 25, bottom: 1),
                child: TextField(
                  controller: Telefono,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'Telefono',
                      hintText: 'Palabra clave de la busqueda'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, top: 0.5, right: 25, bottom: 1),
                child: TextField(
                  controller: Horario,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'Horario del Negocio',
                      hintText: 'Palabra clave de la busqueda'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, top: 0.5, right: 25),
                child: TextField(
                  controller: Maps,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'Maps del Negocio',
                      hintText: 'Palabra clave de la busqueda'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, top: 0.5, right: 25),
                child: TextField(
                  controller: Servicio,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'Servicio del Negocio',
                      hintText: 'Palabra clave de la busqueda'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, top: 0.5, right: 25),
                child: TextField(
                  controller: Tipo,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'Tipo del Negocio',
                      hintText: 'Palabra clave de la busqueda'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, top: 0.5, right: 25),
                child: TextField(
                  controller: Web,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'Web del Negocio',
                      hintText: 'Palabra clave de la busqueda'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, top: 0.5, right: 25),
                child: TextField(
                  controller: ProductoServicio,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'ProductoServicio del Negocio',
                      hintText: 'Palabra clave de la busqueda'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, top: 0.5, right: 25),
                child: TextField(
                  controller: Imagen,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: 'Logo del Negocio',
                      hintText: 'Palabra clave de la busqueda'),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(),
                  child: ElevatedButton(
                    onPressed: () {

                      registroTienda();
                      Nombre.clear();
                      Direccion.clear();
                      Telefono.clear();
                      Horario.clear();
                      Maps.clear();
                      Servicio.clear();
                      Tipo.clear();
                      Web.clear();
                      ProductoServicio.clear();
                      Imagen.clear();
                      print('Presione el boton');
                    },
                    child: Text('Crear Negocio'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                    ),
                  )),
              botonSection,
            ])),
    );
  }
}


