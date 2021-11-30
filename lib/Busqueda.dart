import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:todo_aqui/Negocios/negocio.dart';



class busqueda extends StatefulWidget{
  @override
  _busqueda createState() => _busqueda();
}

class _busqueda extends State<busqueda> {
  final TextEditingController _searchController = TextEditingController();
  late Future resultsLoaded;
  List _allResults=[];
  List _resultList=[];

  @override
  void initState(){
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose(){
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    resultsLoaded =getNegocioSnapshot();
  }
  _onSearchChanged(){
    searchResultList();
  }


  searchResultList(){
    var showResult=[];
    if(_searchController.text != ""){
      for(var NegSnapshot in _allResults){
        var title = Negocio.fromSnapshot(NegSnapshot).Nombre.toLowerCase();
        if(title.contains(_searchController.text.toLowerCase())){
          showResult.add(NegSnapshot);
        }
      }
    } else{
      showResult = List.from(_allResults);
    }
    setState(() {
      _resultList = showResult;
    });
  }

  getNegocioSnapshot() async {
    var data = await FirebaseFirestore.instance.collection("Negocios").get();
    setState((){
      _allResults = data.docs;
    });
    searchResultList();
    return "complete";
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.orange[50],
      resizeToAvoidBottomInset: false,
      body: Column(

        children: <Widget>[
          Text("Negocios"),
          Padding(

            padding: const EdgeInsets.all(1.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
            ) ,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _resultList.length,
                itemBuilder: (BuildContext context, int index) =>
                    NegocioCard(context,_resultList[index])),
          ),
        ],
      ),
    );
  }
  Widget NegocioCard(BuildContext context,DocumentSnapshot document){
    final neg= Negocio.fromSnapshot(document);
    return Container(

      child: Card(
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Row(children: <Widget>[
                    Text(neg.Nombre),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Row(children: <Widget>[
                    Text(neg.Servicios),
                    Spacer(),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Row(children: <Widget>[
                    Text(neg.Tipo),
                    const Spacer(),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}