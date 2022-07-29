import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram/models/users.dart' as model;
//servirá para notificar de cambios y actualizar valores
//cuando se llame a refresh user, se activará el notificar al listener, 
//eso hará que los que estén debajo del change notifier actualicen los valores
class UserProvider extends ChangeNotifier{
  model.User? user;
  model.User get getUser{ //el get es para indicar que es un getter, le quitas los parametros y tal :3
    return user!;
  }

  Future<void> refreshUser()async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get(); //pedimos que nos de la info del usuario actual
    user = model.User.fromSnap(snap); //lo convertimos al formato que nos interesa
    notifyListeners(); //avisamos del cambio
  }

}