import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageMethods{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //adding image to firebase storage
  Future<String> uploadImageToStorage(String childName, Uint8List file, [bool isPost=false]) async{
    //child es para tener carpetas, es decir
    //storage->childName (profilepic, post...)->id del usuario que ha subido eso
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);
    //ref.putFile(File(file.path)) esto no por el tema web
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    return await snap.ref.getDownloadURL();
  }
}