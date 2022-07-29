
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String email;
  final String password;
  final String username;
  final String bio;
  final List followers;
  final List following;
  //constructor de la clase
  const User({
    required this.email,
    required this.password,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });
  //la clave es string y el valor es dinámico
  Map<String, dynamic> toJson(){  
    return {
      "email": email,
      "password": password,
      "username": username,
      "bio": bio,
      'followers' : followers,
      'following' : following,
      //'photoUrl' : photoUrl,
    };
  }
  //convierte del snap obtenido de firebase al modelo user de dart
  static User fromSnap(DocumentSnapshot snap){
    return User(email: snap.get('email'), password: snap.get('password'), username: snap.get('username'), bio: snap.get('bio'), followers: snap.get('followers'), following: snap.get('following'));
  }
}