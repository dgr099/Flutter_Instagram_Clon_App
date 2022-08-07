import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset('assets/ic_instagram.svg',
                color: primaryColor,
                height: 64/2,),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.message_outlined))
        ],
      ),
      body: Center(
          child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 500,
                ), 
                child: //PostCard()
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('posts').snapshots(),
                  builder: ((context, AsyncSnapshot <QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){ //mientrás espere la conexión
                      return Center(child: CircularProgressIndicator(color: primaryColor),);
                    }
                    //en cambio si hay conexión
                    //list view es como una optimización de singlescrollview + column
                    return ListView.builder(
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                      return PostCard(
                        snap: snapshot.data!.docs[index] //cogemos por cada uno de los post y generamos el post
                      );
                    },);
                  }),
                )
                ),)
      );
  }
}