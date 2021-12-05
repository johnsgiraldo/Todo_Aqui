import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_aqui/Negocios/ObjetoTienda.dart';
import 'package:todo_aqui/Usuarios/Login.dart';
import 'package:todo_aqui/Usuarios/Token.dart';
import 'Productos.dart';
import 'RegProductos.dart';

class ShopOne extends StatefulWidget {
  final ObjetoTienda tiendaObj;
  ShopOne(this.tiendaObj);
  @override
  ShopOneApp createState() => ShopOneApp();
}

class ShopOneApp extends State<ShopOne> {
  final firebase = FirebaseFirestore.instance;
  //String logo = "";
  //String titulo = "";
  //String idTienda="";
  //String descripcion = "";
  //int cont = 0;
  //String NombreP="";
  //String PrecioP="";
  //ShopOneApp() {
    //buscarDoc();
 // }

  buscarDoc() async {
    try {
      CollectionReference ref =
      FirebaseFirestore.instance.collection("Negocios");
      QuerySnapshot tienda = await ref.get();

      if (tienda.docs.length != 0) {
        for (var cursor in tienda.docs) {
          if (cursor.id == widget.tiendaObj.idTienda) {
            //this.logo = cursor.get("Imagen");
            widget.tiendaObj.nombre = cursor.get("Nombre");
            widget.tiendaObj.imagen = cursor.get("Imagen");
            print(widget.tiendaObj.idTienda + " id importado");
            //print(this.logo);
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //agregarCarrito(NombreP, PrecioP) async {
  agregarCarrito(String idTienda,String idUser, String idItem) async {

    try {
      await firebase.collection("Carrito").doc().set({
        "UsuarioId":idUser,
        "TiendaId":idTienda,
        "ProductoId": idItem,
        //"Precio": PrecioP,
        //"Nombre": NombreP,
      });
      // mensaje1("Correcto","Registro correto");
    } catch (e) {
      print(e);
      // mensaje("Error...",""+e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.tiendaObj.idTienda);
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
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
                    widget.tiendaObj.nombre,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  widget.tiendaObj.des_larga,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('41'),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'Teléfono'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.web, 'WebSite'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        widget.tiendaObj.prodserv,
        /*'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',*/
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: widget.tiendaObj.nombre,
      home: Scaffold(
          backgroundColor: Colors.orange[50],
          appBar: AppBar(
            title: Text(widget.tiendaObj.nombre),
            backgroundColor: Colors.teal[100],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Image.asset(
                      'image/' + widget.tiendaObj.imagen,
                      //'image/logo.png',
                      width: 600,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                    titleSection,
                    buttonSection,
                    textSection,
                  ],
                ),
              ),
              Center(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Productos",
                        style: TextStyle(fontSize: 25, color: Colors.blueGrey),
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.teal,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    RegistroProducto(widget.tiendaObj.idTienda)));
                      },
                      //child: const Icon(Icons.add_box),
                      child: Text("add"),
                      tooltip: "Agregar producto",
                    )
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Producto")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data!.docs[index].get("IdTienda") ==
                            widget.tiendaObj.idTienda) {
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
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
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
                                                  .get("Descripcion"),
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                            Text(
                                            '\u{1F4B2}'+snapshot.data!.docs[index]
                                                  .get("Precio"),
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
                                                  .get("imagen"),
                                        ),
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {
                                          String NombreP=snapshot.data!.docs[index].get("Nombre");
                                          String PrecioP=snapshot.data!.docs[index].get("Precio");
                                          //agregarCarrito(NombreP, PrecioP);
                                        },
                                        child:
                                        const Icon(Icons.add_shopping_cart),
                                        tooltip: "Agregar al carrito",
                                        backgroundColor: Colors.teal,
                                      ),
                                      FloatingActionButton(
                                        onPressed: () async{
                                          Token tk=new Token();
                                          String idUser=await tk.validarToken();
                                          print(idUser);
                                          if(idUser != ""){
                                            agregarCarrito(widget.tiendaObj.idTienda, idUser,snapshot.data!.docs[index].id);
                                          }else{
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) => Login()));
                                          }
                                          //this.idDoc=snapshot.data!.docs[index].id;
                                          //Navigator.push(context, MaterialPageRoute(builder: (_) => Productos(this.idDoc)));
                                        },
                                        //child: const Icon(Icons.add_shopping_cart),
                                        child: Text("Ver"),
                                        tooltip: "Agregar al carrito",
                                        backgroundColor: Colors.teal,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        } // fin if
                        else {
                          return new Card();
                        }
                      },
                    );
                  },
                ),
              )
            ],
          )),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
