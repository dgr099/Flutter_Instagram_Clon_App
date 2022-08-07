import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';

class PostCard extends StatelessWidget {
  final snap;
  //Reference pathReference = FirebaseStorage.instance.ref().child("profilePics");
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Reference pathReference = FirebaseStorage.instance.ref().child("profilePics").child(snap['uid']);
    String url = "";
    pathReference.getDownloadURL().then((url1){
      url=url1;
    });

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          //Primero va el username y tal
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4, horizontal: 4*4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.account_circle_sharp, color: secondaryColor, size: 40),
                    //CircleAvatar(backgroundColor: Colors.grey, radius: 20),
                    Container(child: Text(snap['username']), padding: EdgeInsets.symmetric(horizontal: 5),)
                  ],
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
              ],
            ),
          ),
          //Aquí va la imagen
          SizedBox(
            //height: MediaQuery.of(context).size.width*0.7, //una altura conforme a la altura del dispositivo
            width: double.infinity, //que aproveche todo el ancho de pantalla
            child: Image.network(snap['postUrl'], fit: BoxFit.cover,),
          ),
          //La zona de like y comment
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            //Like, comment y share van juntos
              Row(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.comment_outlined)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.send)),
                ],
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_border)),
            ],
          ),
          //Los me gusta y la descripción
          Container(child: RichText(text: TextSpan(
            children: [TextSpan(text: "Les gusta a ", style: TextStyle(color: secondaryColor)), TextSpan(text: "@username", style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor)), TextSpan(text: " y ", style: TextStyle(color: secondaryColor)), TextSpan(text: "30 personas más", style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor))], 
          )), 
          width: double.infinity,
          padding: EdgeInsets.only(left: 15),), //la sizedbox es para que ocupe todo y se ponga a la izquierda
          Container(child: RichText(text: TextSpan(
            children: [TextSpan(text: snap['username'], style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)), TextSpan(text: snap['description'], style: TextStyle(color: secondaryColor))]
          )), 
          width: double.infinity,
          padding: EdgeInsets.only(left: 15)),
          Container(
            child: Text("View all comments", style: TextStyle(color: secondaryColor),),
            width: double.infinity,
            padding: EdgeInsets.only(left: 15)
          ),
          Container(
            child: Text(DateTime.fromMillisecondsSinceEpoch(snap['datePublished'].millisecondsSinceEpoch).day.toString() + "/" + DateTime.fromMillisecondsSinceEpoch(snap['datePublished'].millisecondsSinceEpoch).month.toString() + "/" + DateTime.fromMillisecondsSinceEpoch(snap['datePublished'].millisecondsSinceEpoch).year.toString(), style: TextStyle(color: secondaryColor),),
            width: double.infinity,
            padding: EdgeInsets.only(left: 15)
          )
        ],
      ),
    );
  }
}