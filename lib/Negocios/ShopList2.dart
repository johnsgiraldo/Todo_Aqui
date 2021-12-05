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
import 'ObjetoTienda.dart';
import 'ShopOne.dart';

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
  String idDoc="";
  @override
  String texto1="Cigarreria Tio Tom";
  String texto2="Bruder";
  ObjetoTienda objTienda=new ObjetoTienda();

  buscarDoc(String docId) async {
    try {
      CollectionReference ref =
      FirebaseFirestore.instance.collection("Negocios");
      QuerySnapshot tienda = await ref.get();

      if (tienda.docs.length != 0) {
        for (var cursor in tienda.docs) {
          if (cursor.id == docId) {
            objTienda.nombre=cursor.get("Nombre");
            objTienda.des_corta=cursor.get("Tipo");
            objTienda.des_larga=cursor.get("Servicio");
            objTienda.telefono=cursor.get("Telefono");
            objTienda.website=cursor.get("Web");
            objTienda.imagen=cursor.get("Imagen");
            objTienda.idTienda=cursor.id;
            objTienda.prodserv=cursor.get("ProductoServicio");
            //this.logo = cursor.get("rutaFoto");
            //this.titulo = cursor.get("Nombre");

            //print(widget.docId + " id importado");
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {


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
                                //'Compras en tienda',
                                snapshot.data!.docs[index].get("Tipo"),
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
                          child: Image.asset(
                            "image/" +
                                snapshot.data!.docs[index]
                                    .get("Imagen"),
                          ),
                          padding: const EdgeInsets.only(right: 8),
                        ),
                        ElevatedButton(onPressed: (){
                          this.idDoc=snapshot.data!.docs[index].id;
                          buscarDoc(this.idDoc);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ShopOne(objTienda)));
                        }, child: Text("Info"), style: ElevatedButton.styleFrom(
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