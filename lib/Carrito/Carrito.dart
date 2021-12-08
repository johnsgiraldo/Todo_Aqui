import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Carrito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Carrito2());
  }
}

class Carrito2 extends StatefulWidget {
  @override
  Carrito2App createState() => Carrito2App();
}

class Carrito2App extends State<Carrito2> {
  @override
  String idDoc="";
  TextEditingController cant=TextEditingController();
  final firebase=FirebaseFirestore.instance;

  borrarDocumento(String idItem) async{
    try{
      await firebase.collection("Carrito").doc(idItem).delete();
    }catch(e){
      print(e);
    }

  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text("Carrito de Compras"),
        backgroundColor: Colors.teal[100],
      ),
      body: Container(
        child: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Carrito").snapshots(),
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
                                        snapshot.data!.docs[index].get("NombreProd"),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        snapshot.data!.docs[index].get("DescripcionProd"),
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      //'Compras en tienda',
                                      snapshot.data!.docs[index].get("PrecioProd"),
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
                                          .get("ImagenProd"),
                                ),
                                padding: const EdgeInsets.only(right: 8),
                              ),
                              Container(
                                width: 70,
                                height: 70,
                                child: TextField(
                                  //controller: cant,
                                ),
                                padding: const EdgeInsets.only(right: 8),
                              ),
                              FloatingActionButton(
                                onPressed: () async{
                                  mensaje("Borrado", "¿Desea borrar el articulo?", snapshot.data!.docs[index].id);
                                },
                                child: const Icon(Icons.remove),
                                //child: Text("Ver"),
                                tooltip: "Agregar al carrito",
                                heroTag: null,
                                backgroundColor: Colors.teal,
                              )
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

  void mensaje(String titulo,String mess, String idItem){
    showDialog(context: context, builder: (builcontex){
      return AlertDialog(
        title: Text(titulo),
        content: Text(mess),
        actions: [
          RaisedButton(onPressed: (){
            //Navigator.of(context).pop();
          },
            child: Text("Cancelar",
              style: TextStyle(color:Colors.teal),),
          ),
          RaisedButton(onPressed: () async{
            await borrarDocumento(idItem);
            //Navigator.of(context).pop();
          },
            child: Text("Aceptar",
              style: TextStyle(color:Colors.teal),),
          ),
        ],
      );
    });
  }

}