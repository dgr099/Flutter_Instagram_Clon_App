import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  //future porque los calls son asíncronos
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    Uint8List? file,
  }
  ) async {
    String res = "Error";
    //intentamos hacer el sign up
    try {
      if (!(email.isEmpty || password.isEmpty || username.isEmpty || bio.isEmpty)){ //comprobamos los parámetros
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        // añadimos el usuario a la base de datos
        //creamos una entrada en users con el id de cred
        //también podemos usar el add, en ese caso pondrá un id aleatorio
        //primero procuro subir 
        if(file!=null){ //si introdujo una foto de perfil
          String photoUrl = await StorageMethods().uploadImageToStorage("profilePics", file);
          print(photoUrl);
        }
        await _firestore.collection('users').doc(cred.user!.uid).set( //!. comprueba que no sea null creed y devuelve el valor
          //creamos la entrada para usuario
          {
            'username' : username,
            'uid' : cred.user!.uid,
            'email' : email,
            'bio' : bio,
            'followers' : [],
            'following' : [],
            //'photoUrl' : photoUrl,
          }
        );
        res = "Succes";
      }
    } on FirebaseAuthException catch(err){
      if(err.code=="invalid-email"){
        res = 'The email is badly formated';
      }
    }
    catch (err) {
      res = err.toString();
      print(res);

    }
    return res; //devuelvo el string resultado de la operación

  }
}
