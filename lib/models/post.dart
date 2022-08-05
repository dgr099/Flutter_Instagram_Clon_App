import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid; //user uid
  final String username; //redundancia
  final String postId;
  final DateTime datePublished;
  final String postUrl; //redundancia
  final List likes; //aquí no es un entero porq queremos guardar conocimiento de quien da like
  //constructor de la clase
  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.likes,
  });
  //la clave es string y el valor es dinámico
  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "uid": uid,
      "username": username,
      "postId": postId,
      'datePublished': datePublished,
      'postUrl': postUrl,
      'likes': likes,
      //'photoUrl' : photoUrl,
    };
  }

  //convierte del snap obtenido de firebase al modelo Post de dart
  static Post fromSnap(DocumentSnapshot snap) {
    return Post(
        description: snap.get('description'),
        uid: snap.get('password'),
        username: snap.get('username'),
        postId: snap.get('postId'),
        datePublished: snap.get('datePublished'),
        postUrl: snap.get('postUrl'),
        likes: snap.get('likes'),
        
        );
  }
}
