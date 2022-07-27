import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  Uint8List? _image;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _biocontroller.dispose();
    _usernamecontroller.dispose();
    super.dispose();
  }

  //función para registrar usuario
  void signUpUser() async {
    String res = await AuthMethods().signUpUser(
                  email: _emailController.text,
                  password: _passwordController.text,
                  username: _usernamecontroller.text,
                  bio: _biocontroller.text,
                  file: _image);

    if(res!="Succes"){ //si hubo algún error debe mostrarlo

    }

  }

  //función para seleccionar imagen
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    //hacemos un set state para el rebuild actualizando las variables de imagen
    setState(() {
      _image = im; //actualizamos la imagen
    });
  }

  @override
  Widget build(BuildContext context) {
    //la página de login
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Imagen del logo
            Container(
              padding: EdgeInsets.only(top: 30, bottom: 15),
              child: SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
            ),
            //widget para poner foto de perfil y tal
            Stack(
              children: [
                _image != null //si no hay imagen carga el avatar
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                        backgroundColor: Colors.grey,
                      )
                    : CircleAvatar( //si hay imagen ponme la imagen
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/21/21104.png'),
                        backgroundColor: Colors.grey,
                      ),
                Positioned(
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                  bottom: -10,
                  left: 80,
                )
              ],
            ),
            //espacio
            const SizedBox(
              height: 20,
            ),
            //Text field para el correo
            TextFieldInput(
                textEditingController: _emailController,
                hintText: "Enter your email",
                textInputType: TextInputType.emailAddress),
            //espacio
            const SizedBox(
              height: 24,
            ),
            //Como el anterior pero para el correo
            TextFieldInput(
              textEditingController: _usernamecontroller,
              hintText: "Enter your username",
              textInputType: TextInputType.text,
              isPass: true,
            ),
            //espacio
            const SizedBox(
              height: 24,
            ),
            //Como el anterior pero para el correo
            TextFieldInput(
              textEditingController: _biocontroller,
              hintText: "Enter your bio",
              textInputType: TextInputType.text,
              isPass: true,
            ),
            //espacio
            const SizedBox(
              height: 24,
            ),
            //Como el anterior pero para el correo
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: "Enter your password",
              textInputType: TextInputType.text,
              isPass: true,
            ),
            //espacio
            const SizedBox(
              height: 12,
            ),
            //container con el register
            InkWell(
              onTap: signUpUser,
              child: Container(
                child: const Text("Sign Up"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        //Ponemos margen a los lados
        padding: const EdgeInsets.symmetric(horizontal: 32),
        //Que ocupe todo el ancho que pueda
        width: double.infinity,
      )),
    );
  }
}
