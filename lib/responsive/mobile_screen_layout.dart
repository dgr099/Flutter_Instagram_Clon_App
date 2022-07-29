import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/users.dart' as models;
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";
  @override
  void initState() {
    //está función mejor no hacerla async porque puede dar errores
    // TODO: implement initState
    super.initState();
    //getUsername();
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
  int _selectedTab = 0; //index selector de página
  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  List _pages = [
    Text("1"),
    Text("2"),
    Text("3"),
    Text("4"),
    Text("5"),
    Text("6"),
  ];
  @override
  Widget build(BuildContext context) {
    //models.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(child:_pages[_selectedTab]),
      //bottomNavigationBar: CupertinoTabBar(items: [BottomNavigationBarItem(icon: Icon(Icons.access_alarm)),BottomNavigationBarItem(icon: Icon(Icons.abc))]),
      /*bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home, color: _page==0 ? primaryColor : secondaryColor,), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.search, color: _page==1 ? primaryColor : secondaryColor,), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle,color: _page==2 ? primaryColor : secondaryColor,), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.favorite, color: _page==3 ? primaryColor : secondaryColor,), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person, color: _page==4 ? primaryColor : secondaryColor,), label: ""),
      ],),*/
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.search,), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle,), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.favorite,), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person,), label: ""),
      ],
      selectedItemColor: primaryColor, unselectedItemColor: secondaryColor, currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),),
      //body: Center(child: Text('$username')),
      //body: Center(child: Text(user.username)),
    );
  }
}
