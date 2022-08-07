import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/users.dart' as models;
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/screens/feed_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";
  late PageController pageController;
  @override
  void initState() {
    //está función mejor no hacerla async porque puede dar errores
    // TODO: implement initState
    super.initState();
    //getUsername();
    pageController = PageController(); //inicializamos el controlador de páginas
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
  
  void navigationTapped(int page){
    //esto sirve para cambiar la imagen del page view, pero al no actualizar state no se cambian los colores
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page){
    setState(() {
      _page=page; //actualizamos el page, cambia color barra inferior
    });
  }
  void getUsername() async {
    //obtengo la instancia de usuario del id del usuario actual
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = snap.get('username');
      //username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }
  int _page = 0; //index selector de página
  @override
  Widget build(BuildContext context) {
    //models.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(
        //lo bueno del page view es que permite el scroll
        child: PageView(children: [
          FeedScreen(),
          Text('3'),
          AddPostScreen(),
          Text('4'),
          Text('5'),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        ),
      ),
      //bottomNavigationBar: CupertinoTabBar(items: [BottomNavigationBarItem(icon: Icon(Icons.access_alarm)),BottomNavigationBarItem(icon: Icon(Icons.abc))]),
      bottomNavigationBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home, color: _page==0 ? primaryColor : secondaryColor,), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.search, color: _page==1 ? primaryColor : secondaryColor,), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle,color: _page==2 ? primaryColor : secondaryColor,), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.favorite, color: _page==3 ? primaryColor : secondaryColor,), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person, color: _page==4 ? primaryColor : secondaryColor,), label: ""),
      ], onTap: navigationTapped,),
      //body: Center(child: Text('$username')),
      //body: Center(child: Text(user.username)),
    );
  }
}
