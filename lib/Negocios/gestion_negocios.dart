import 'package:flutter/material.dart';
import 'package:todo_aqui/Negocios/RegistroNegocio.dart';

class gestionNegocios extends StatefulWidget{
  @override
  _gestionNegocios createState() => _gestionNegocios();
}

class _gestionNegocios extends State<gestionNegocios>{

  @override
  Widget build(BuildContext context) {

    Widget registroTienda = Container(
      child: Column(children:<Widget> [
        Padding(
          padding: const EdgeInsets.all(25),
          child: Column(children: [
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return Registro();
              }
              ));

            },
                child: const Text('Registrar Negocio')),
          ]),
        ),
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
            registroTienda,
          ],
        ),
      ),
    );
  }
}
