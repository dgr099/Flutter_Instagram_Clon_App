import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/firestore_methods.dart';
import 'package:instagram/responsive/mobile_screen_layout.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool _isloading = false;
  Uint8List? _image;
  String _user_image_url="";
  final TextEditingController _captionContoller = TextEditingController();
  final storageRef = FirebaseStorage.instance.ref();
  @override
  void initState() {
    // cogemos la referencia de la profile pic del usuario
    profilePic();
    //prueba();
    super.initState();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    _captionContoller.dispose();
    super.dispose();
  }
  /*void prueba() async{
    _image2 = await storageRef.child("profilePics").child("Screenshot_1659207620.png").getData();
    setState(() {  
    });
  }*/

  void profilePic() async{
    Reference pathReference = storageRef.child("profilePics");
    pathReference = pathReference.child(FirebaseAuth.instance.currentUser!.uid);
    print("se esta intentando");
    try {
      String url_user = await pathReference.getDownloadURL();
      setState(() {
        _user_image_url=url_user;
        print(_user_image_url);
      });
      // Data for "images/island.jpg" is returned, use this as needed.
    } on FirebaseException catch (e) {
      return;
    }
  }
//misma función que en el sign up pero está vez para
//función para seleccionar imagen
  void selectImage() async {
    Uint8List? _img;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Create a new Post"),
            children: [
              SimpleDialogOption(
                child: Text("From Camera"),
                onPressed: () async{
                  Navigator.pop(context); //cerramos el diálogo
                    _img = await pickImage(ImageSource.gallery); //escogemos la camara
                    update_img(_img);
                },
              ),
              SimpleDialogOption(
                child: Text("From Gallery"),
                onPressed: () async{
                  Navigator.pop(context); //cerramos el diálogo
                    _img = await pickImage(ImageSource.gallery); //escogemos la galería
                    update_img(_img);
                },
              ),
              SimpleDialogOption(
                child: Text("Cancel"),
                onPressed: () async{
                  Navigator.pop(context); //cerramos el diálogo
                },
              ),
            ],
          );
        });
  }

  //esta función actualiza visualmente el post
  void update_img(Uint8List? _img){
    print("x aqui estamos jeje");
    setState(() {
      _image=_img;
    });
  }

  void uploadPost() async{
    setState(() {
      _isloading=true; //ponemos como que está cargando
    });
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    String username = snap.get('username');
    String res = await FirestoreMethods().uploadPost(_captionContoller.text, _image!, FirebaseAuth.instance.currentUser!.uid, username);
    if(res!="Succes"){
      showInfoMessage(cont: res, tittle: "Error on upload Post", context: context);
    }
    Uint8List? emptyImg;
    setState(() {
      _image=emptyImg; //reiniciamos la imagen
      showInfoMessage(cont: res, tittle: "Post already Upload", context: context);
    });
    setState(() {
      _isloading=true; //ponemos como que está cargando
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post to"),
        leading:
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView( //por el tema del overflow
        child: Column(children: [
          const SizedBox(
            height: 24,
          ),
          //SizedBox(width: MediaQuery.of(context).size.width*0.85, child: AspectRatio(aspectRatio: 487/451, child: Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1563089145-599997674d42?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"), fit: BoxFit.fill, alignment: FractionalOffset.center)),)),),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: AspectRatio(
                aspectRatio: 487 / 451,
                child: Container(
                  clipBehavior: Clip.hardEdge, //para recortar con el borde redondeado
                  child: InkWell(onTap: selectImage, child: _image==null ? Icon(Icons.photo) : Image.memory(_image!, fit: BoxFit.cover,)),
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                )),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  backgroundImage: _image!=null ? Image.memory(_image!,
              ).image :  NetworkImage('https://cdn-icons-png.flaticon.com/512/21/21104.png'),),
              //Image.memory(_user_image_url!, fit: BoxFit.cover,).image),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "write a caption", border: InputBorder.none),
                  maxLines: 2,
                  maxLength: 300,
                  controller: _captionContoller,
                ),
              ),
              InkWell(
                child: Container(child: Icon(Icons.check)),
                onTap: uploadPost,
              ),
            ],
          )
        ]),
      ),
    );
  }
}
