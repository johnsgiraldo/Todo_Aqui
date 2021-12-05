import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_aqui/Negocios/ObjetoTienda.dart';
import 'package:todo_aqui/Negocios/ShopOne.dart';

import 'package:todo_aqui/Negocios/negocio.dart';




class Search extends StatefulWidget{
  final String buscar;
  Search(this.buscar);
  @override
  SearchApp createState() => SearchApp();
}

class SearchApp extends State<Search>{
  String idDoc="";


  @override
  Widget build(BuildContext context){
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

    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text("Resultado de la búsqueda"),
        backgroundColor: Colors.teal[100],
      ),body: Container(
      child: Center(
        child: StreamBuilder(
          stream:
          FirebaseFirestore.instance.collection("Negocios").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                if(snapshot.data!.docs[index].get("Nombre").toString().toUpperCase().contains(widget.buscar.toUpperCase())) {
                  //print(snapshot.data!.docs[index].id);

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
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    /*2*/
                                    Container(
                                      padding:
                                      const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        snapshot.data!.docs[index]
                                            .get("Nombre"),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]
                                          .get("Tipo"),
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
                                  "image/" + snapshot.data!.docs[index]
                                  .get("Imagen"),),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    this.idDoc=snapshot.data!.docs[index].id;
                                    buscarDoc(this.idDoc);
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => ShopOne(objTienda)));
                                  }, child: Text("Entrar"), style: ElevatedButton.styleFrom(
                                primary: Colors.teal,
                              ),)
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }else{
                  return new Card();
                }
              },
            );
          },
        ),
      ),
    ),
    );
  }
}