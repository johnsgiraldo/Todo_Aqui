import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Home.dart';
import 'package:todo_aqui/Usuarios/Login.dart';

void main() {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: LoadPage()
    );
  }
}


class LoadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Aqui',
      home: Scaffold(
        backgroundColor: Colors.orange[50],
        body: Center(
          child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 250, bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      /*Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                      return Home();
                    }
                    ));*/

                    },
                    child: Center(child: Image.asset('image/logo.png')),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Home()));
                        print('Presione el boton');
                      },
                      child: Text('Entrar como Invitado'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Login()));
                        print('Presione el boton');
                      },
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                      ),
                    )),
              ]),
        ),
      ),
    );
  }
}
