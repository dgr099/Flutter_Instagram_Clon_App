import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/responsive/mobile_screen_layout.dart';
import 'package:instagram/responsive/responsive_layout_screen.dart';
import 'package:instagram/responsive/web_screen_layout.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/screens/singup_screen.dart';


void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //me aseguro que se haya iniciado flutter
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCnTCmT-QlhlsFwYd6guvIB-CvNOJ0VDmo",
            appId: "1:1063359643132:web:c26b0b22a545cf26140679",
            messagingSenderId: "1063359643132",
            projectId: "instagram-clone-58d57",
            storageBucket: "instagram-clone-58d57.appspot.com")); //esperamos a que se inicializa el FireBase
  } else {
    await Firebase.initializeApp(); //esperamos a que se inicializa el FireBase
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      theme: ThemeData.dark(
          //primarySwatch: Colors.blue,
          ),
      /*home: const ResponsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout()),*/
        home: LoginScreen()
    );
  }
}
