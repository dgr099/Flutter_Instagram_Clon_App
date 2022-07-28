import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async{
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if(_file!=null){ //si seleccionó una imagen de forma correcta
    //no devolvemos file por el tema de dart.io que no es muy accesible en internet
    return await _file.readAsBytes();
  }
}

void showErrorMessage({required BuildContext context, required String cont, required String tittle}){
  showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(cont),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            );
          });
}