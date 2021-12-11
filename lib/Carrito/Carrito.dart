import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarritoCompras extends StatefulWidget{
  final String idUser;
  CarritoCompras(this.idUser);
  @override
  CarritoComprasApp createState() => CarritoComprasApp();
}

class CarritoComprasApp extends State<CarritoCompras>{
  TextEditingController cant=TextEditingController();

  final firebase=FirebaseFirestore.instance;
  var flag=0;
  var costototal=0;
  var precio=0;
  var costototal2=0;
  var precio2=0;
  bool? valor = false;
  bool? valor2 = false;
  TextEditingController cost = TextEditingController();


  borrarDocumento(String idItem) async{
    try{
      await firebase.collection("Carrito").doc(idItem).delete();
    }catch(e){
      print(e);
    }

  }

  totalizarCarrito() async{
    try{
      CollectionReference ref=FirebaseFirestore.instance.collection("Carrito");
      QuerySnapshot carrito=await ref.get();

      if(carrito.docs.length !=0){
        for(var cursor in carrito.docs){
          if(cursor.get("UsuarioId")==widget.idUser){
            precio=int.parse(cursor.get("PrecioProd"));
            print(precio);
            costototal=costototal+precio;
            print(costototal);
            flag=1;
            //return costototal;
          }

          }
        return costototal;
        }
        /*if (flag==0){
          print("Login Usuario NO encontrado");

      }else{
        print("Collección vacía");
      }*/
    }catch(e){

    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text("Carrito de Compras"),
        backgroundColor: Colors.teal[100],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Carrito").snapshots(),
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData) return CircularProgressIndicator();
                  costototal=0;
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index){
                        if(snapshot.data!.docs[index].get("UsuarioId")==widget.idUser){
                          //TextEditingController cant = TextEditingController();
                          //cant.text=snapshot.data!.docs[index].get("Cantidad").toString();
                          precio=(snapshot.data!.docs[index].get("Total"));
                          //print(precio);
                          costototal=costototal+precio;
                          //print(costototal);
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
                                              'Costo uni:'+'\u{1F4B2}'+snapshot.data!.docs[index].get("PrecioProd"),
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                            Text(
                                              //'Compras en tienda',
                                              'SubTotal:'+'\u{1F4B2}'+snapshot.data!.docs[index].get("Total").toString(),
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
                                        padding: const EdgeInsets.only(bottom: 0, left: 10, right: 10),
                                          //width: 70,
                                          //height: 70,
                                          child: Text(
                                              //'Compras en tienda',
                                              'Cant: '+snapshot.data!.docs[index].get("Cantidad").toString(),
                                              style: TextStyle(
                                              color: Colors.grey[500],
                                              ),),),
                                      FloatingActionButton(
                                        onPressed: () async{
                                          mensaje("Borrado", "¿Desea borrar el articulo?", snapshot.data!.docs[index].id);
                                          //costototal=costototal-precio;
                                        },
                                        child: const Icon(Icons.remove),
                                        //child: Text("Ver"),
                                        tooltip: "Borrar del carrito",
                                        heroTag: null,
                                        backgroundColor: Colors.teal,
                                      )
                                    ],
                                  ),
                                )

                              ],
                            ),

                          );

                        }else{
                          return new Card();
                        }

                      });
                },
              ),
            ),),

          //totalizarCarrito(),




          Center(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Total a pagar: ",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                ),

              ],
            ),
          ),

          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Precio total:"+'\u{1F4B2}'+costototal.toString(),
                    style: TextStyle(
                      fontSize:20, fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "Recuerda validar los productos antes de proceder con tu pago",
                  style: TextStyle( fontSize:15,
                    color: Colors.grey[500],
                  ),
                ),
                /*Checkbox(
                  value: this.valor,
                  onChanged: (valor) {
                    setState(() {
                      this.valor = valor;
                    });
                  },
                ),*/
                CheckboxListTile(
                  title: Text("¿Desea recoger en tienda?"),
                  //checkColor: Colors.teal,
                  activeColor: Colors.teal,
                  value: valor,
                  onChanged: (newValue) {
                    setState(() {
                      valor = newValue;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                ),
                CheckboxListTile(
                  title: Text("¿Desea entrega a domicilio?"),
                  //checkColor: Colors.teal,
                  activeColor: Colors.teal,
                  value: valor2,
                  onChanged: (newValue) {
                    setState(() {
                      valor2 = newValue;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                ),
                Center(
                    child: ElevatedButton(onPressed: (){

                    }, child: Text("Pagar"), style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                    ),)
                ),

              ],
            ),
          ),
        ],

  ),//Body

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