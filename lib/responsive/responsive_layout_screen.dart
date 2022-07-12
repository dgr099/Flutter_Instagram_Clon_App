import 'package:flutter/material.dart';
import 'package:instagram/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        //lo utilizamos porque su builder tiene constraints lo que nos permite hacerlo más responsive
        builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        //si el tamaño es suficiente mostramos versión de navegaador
        return webScreenLayout;
      }
      else{
        return mobileScreenLayout;
      }
    });
  }
}
