import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  //Valores que obtiene por argumentos
  final TextEditingController textEditingController; //controlador del texto
  final bool isPass; //booleano para saber si es contraseña
  final String hintText; //el texto que se superpone en el textfield
  final TextInputType textInputType;

  const TextFieldInput(
      {Key? key,
      required this.textEditingController,
      this.isPass = false, //por defecto no es una contraseña
      required this.hintText,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
          ),
      keyboardType: textInputType,
      //Para contraseñas y tal
      obscureText: isPass,
    );
  }
}
