import 'package:flutter/material.dart';
import 'package:instagram/providers/user_provider.dart';
import 'package:instagram/utils/dimensions.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    addData();
    super.initState();
  }

  addData()async{
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        //lo utilizamos porque su builder tiene constraints lo que nos permite hacerlo más responsive
        builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        //si el tamaño es suficiente mostramos versión de navegaador
        //return widget.webScreenLayout;
        return widget.mobileScreenLayout;
      }
      else{
        return widget.mobileScreenLayout;
      }
    });
  }
}
