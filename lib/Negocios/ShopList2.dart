import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_aqui/Busqueda.dart';
import 'package:todo_aqui/Home.dart';
import 'package:todo_aqui/Negocios/ShopDetail.dart';
import 'package:todo_aqui/Usuarios/GestionUsuario.dart';
import 'package:todo_aqui/Negocios/ShopList.dart';
import 'package:todo_aqui/Busqueda.dart';
import 'package:todo_aqui/main.dart';
import 'package:todo_aqui/Negocios/RegistroNegocio.dart';
import 'package:todo_aqui/Negocios/negocio.dart';

class Shop2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ShopList());
  }
}

class ShopList2 extends StatefulWidget {
  @override
  ShopList2App createState() => ShopList2App();
}

class ShopList2App extends State<ShopList2> {
  @override
  String texto1="Cigarreria Tio Tom";
  String texto2="Bruder";
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    texto1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Compras en tienda',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Container(
            width: 70,
            height: 70,
            child: Image.asset('image/Tiotom2.jpg'),
            padding: const EdgeInsets.only(right: 8),
          ),
          ElevatedButton(onPressed: (){}, child: Text("Info"), style: ElevatedButton.styleFrom(
            primary: Colors.teal,
          ),)
        ],
      ),
    );

    Widget titleSection2 = Container(
      padding: const EdgeInsets.only(top:15,left: 15, right: 15,bottom: 450),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    texto2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Consumo en el lugar',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Container(
            width: 70,
            height: 70,
            child: Image.asset('image/Bruder.png'),
            padding: const EdgeInsets.only(right: 8),
          ),
          ElevatedButton(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => Shopdetail()));
          }, child: Text("Info"), style: ElevatedButton.styleFrom(
            primary: Colors.teal,
          ),)
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
        title: Text("Lista de tiendas"),
        backgroundColor: Colors.teal[100],
      ),
      body: Container(
        child: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Negocios").snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index){
                  return new Card(
                    child: Column(
                      children: [
                    Container(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          /*1*/
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*2*/
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  snapshot.data!.docs[index].get("Nombre"),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'Compras en tienda',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        /*3*/
                        Container(
                          width: 70,
                          height: 70,
                          child: Image.asset('image/Tiotom2.jpg'),
                          padding: const EdgeInsets.only(right: 8),
                        ),
                        ElevatedButton(onPressed: (){}, child: Text("Info"), style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                        ),)
                      ],
                    ),
                  )

                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}