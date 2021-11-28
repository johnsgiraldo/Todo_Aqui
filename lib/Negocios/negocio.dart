import 'package:cloud_firestore/cloud_firestore.dart';

class Negocio{
  late String Direccion;
  late String Horario;
  late String maps;
  late String Nombre;
  List ProductoServicio =[];
  late String Servicios;
  late String Telefono;
  late String Tipo;
  late String Web;

  Negocio();

  Negocio.fromMap(Map<String, dynamic> data){
    Direccion = data['Direccion'];
    Horario = data['Horario'];
    maps = data['Maps'];
    Nombre = data['Nombre'];
    ProductoServicio = data['ProductoServicio'];
    Servicios = data['Servicios'];
    Telefono = data['Telefono'];
    Tipo = data['Tipo'];
    Web = data['Web'];

  }

  Negocio.fromSnapshot(DocumentSnapshot snapshot){

      Direccion= snapshot['Direccion'];
      Horario= snapshot['Horario'];
      maps = snapshot ['Maps'];
      Nombre = snapshot['Nombre'];
      ProductoServicio = snapshot['ProductoServicio'];
      Servicios = snapshot['Servicio'];
      Telefono = snapshot['Telefono'];
      Tipo = snapshot['Tipo'];
      Web = snapshot['Web'];


  }

}