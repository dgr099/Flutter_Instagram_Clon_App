import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/users.dart' as model; //para que no se confunda con el users de firebase
import 'package:instagram/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  //future porque los calls son asíncronos
  //función para logear usuario
  Future<String> loginUser({
    required String email,
    required String password,
  })async{
    String res = "Error";
    try {
      if (!(email.isEmpty || password.isEmpty)){ //comprobamos los parámetros
      //función future, requerrimos un await
      //intentamos iniciar sesión con password y email
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "Succes";
    } else{
      res = "Please enter email and password";
    }
    } on FirebaseAuthException catch(err){
      if(err.code=="wrong-password"){ //aqui podriamos hacer caths de los + importantes y tal
        res = 'Password is wrong';
      }
      else{
        res = err.code;
      }
    } 
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  //función para registrar usuario
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
        model.User user = model.User(
          bio: bio, email: email, followers: [], following: [], password: password, username: username);
        await _firestore.collection('users').doc(cred.user!.uid).set( //!. comprueba que no sea null creed y devuelve el valor
          //creamos la entrada para usuario, en vez de hacerla manual empleamos la clase usuario
          user.toJson() //requerimos el toJson porque lo que se guarda es un mapa
          /*{
            'username' : username,
            'uid' : cred.user!.uid,
            'email' : email,
            'bio' : bio,
            'followers' : [],
            'following' : [],
            //'photoUrl' : photoUrl,
          }*/
        );
        res = "Succes";
      }else{
        res = "Please enter email and password";
      }
      await _auth.signInWithEmailAndPassword(email: email, password: password); //intentamos iniciar sesión con los valores del sign up
    } on FirebaseAuthException catch(err){
      if(err.code=="invalid-email"){
        res = 'The email is badly formated';
      }
      else{
        res = err.code;
      }
    }
    catch (err) {
      res = err.toString();
    }
    print(res);
    return res; //devuelvo el string resultado de la operación

  }
}
