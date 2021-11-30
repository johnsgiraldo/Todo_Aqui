import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class slideProductos extends StatefulWidget{
  @override
  _slideProductos createState() => _slideProductos();
}

class _slideProductos extends State<slideProductos>{
  late Stream slides;
  // Stream Function
  Stream _queryDb(){
    return slides = FirebaseFirestore.instance.collection('Productos').snapshots().map((list) => list.docs.map((doc) => doc.data()));
  }

  @override
  void initState(){
    _queryDb();
    super.initState();
  }

  final PageController controlslide = PageController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: new AppBar(
          title: new Text("Return"),
          backgroundColor: Colors.teal[100],
        ),
        body: StreamBuilder(
            stream: slides,
            builder: (context, AsyncSnapshot snap){
              // otain current state
              List slideList = snap.data.toList();
              if (snap.hasError){
                return Text("Error");
              }
              if (snap.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              return PageView.builder(
                  controller: controlslide,
                  itemCount: slideList.length,
                  itemBuilder: (context, int index){
                    return _storyPage(slideList[index]);
                  });
            }));
  }
  _storyPage(Map data){
    return Container(
        margin: EdgeInsets.only(top:100,bottom:50,left:10,right:10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(data['imagen']),
          ),
        ),
        child: Center(
            child: Text(
              data['Nombre'],
              style: TextStyle(fontSize: 40, color: Colors.orange[50]),
            )
        )
    );
  }

}