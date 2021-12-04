import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Token{
  FirebaseMessaging messaging=FirebaseMessaging.instance;
  String isToken="";
  FirebaseFirestore firestore=FirebaseFirestore.instance;

  guardarToken(String idUser) async{
    await Firebase.initializeApp();
    isToken=(await FirebaseMessaging.instance.getToken())!;
    //print(isToken);

    try{
      await firestore.collection("Tokens").doc().set({
        "TokenId":isToken,
        "UserId":idUser,
      });
    }catch(e){
      print(e);
    }
  }

  validarToken() async{
    String isSession="";
    try{
      await Firebase.initializeApp();
      isToken=(await FirebaseMessaging.instance.getToken())!;

      CollectionReference ref=FirebaseFirestore.instance.collection("Tokens");
      QuerySnapshot sesion=await ref.get();

      if(sesion.docs.length !=0){
        int flag=0;
        for(var cursor in sesion.docs){
          //print(cursor.get("Correo"));
          if(cursor.get("TokenId")==isToken){
            //print("Correo encontrado");

              print("Token Encontrado");
              flag=1;
              isSession=cursor.get("UserId");
          }
        }
        if(flag==0){
          print("Token NO encontrado");
          //mensaje("Login","Usuario NO encontrado");
        }
      }else{
        print("Coleccion vacia");
      }

    }catch(e){
      print(e);
    }
    return isSession;

  }

}