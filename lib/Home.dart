import 'package:flutter/material.dart';
import 'package:todo_aqui/Busqueda.dart';
import 'package:todo_aqui/Usuarios/GestionUsuario.dart';
import 'package:todo_aqui/Negocios/ShopList.dart';
import 'package:todo_aqui/Negocios/RegistroNegocio.dart';
import 'package:todo_aqui/Negocios/ShopList2.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:todo_aqui/Busqueda/slideProductos.dart';
import 'package:todo_aqui/Busqueda/slideServicios.dart';
// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;



class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Index());
  }
}

class Index extends StatefulWidget {
  @override
  IndexStart createState() => IndexStart();
}


class IndexStart extends State<Index> {
  @override
  Widget build(BuildContext context) {

    //***********Boton Buscar***********
    Widget searchSection = Container(
        child: Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 2),
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Busqueda',
              hintText: 'Palabra clave de la busqueda'),
        ),
      ),
      Padding(
          padding: EdgeInsets.only(),
          child: ElevatedButton(
            onPressed: () {
              print('Presione el boton');
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => busqueda()));
            },
            child: Text('Buscar'),
            style: ElevatedButton.styleFrom(
              primary: Colors.teal,
            ),
          )),
    ]));

    // ********Seccion de Imagenes************
    Widget imagesSection = Container(
      color: Colors.orange[50],
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 25, top: 2, right: 25, bottom: 2),
            child: Center(
              child: Container(
                  width: 300,
                  height: 150,
                  child: Image.asset('image/Promociones-1.png')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, top: 2, right: 25, bottom: 2),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (_) => slideProductos()));
              },
              child: Center(child: Image.asset('image/Productos-1.png')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 80, top: 2, right: 80, bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => slideServicios()));
              },
              child: Center(child: Image.asset('image/Servicios-1.png')),
            ),
          ),
        ],
      ),
    );


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
                      MaterialPageRoute(builder: (_) => ShopList2()));
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



    return MaterialApp(
      title: 'TodoAqui',
      home: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('TodoAqui'),
          backgroundColor: Colors.teal[100],
        ),
        body: ListView(
          children: [
            searchSection,
            imagesSection,
            botonSection,
          ],
        ),
      ),
    );
  }
}
