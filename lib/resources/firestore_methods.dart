import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/post.dart';
import 'package:instagram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String postId = const Uuid().v1(); //genera un id único (para poder guardar su id)
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
  ) async{
    String res = "Some error ocurred";
    try {
      //primero guardas la imagen como tal
      String url = await StorageMethods().uploadImageToStorage("posts", file, true, postId);
      Post post = Post(description: description, uid: uid, username: username, postId: postId, datePublished: DateTime.now(), postUrl: url, likes: []);
      //una vez tienes creado el post, falta storearlo
      _firestore.collection('posts').doc(postId).set(post.toJson()); //guardamos el usuario
      res = "Succes";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}