import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utils/colors.dart';
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _biocontroller.dispose();
    _usernamecontroller.dispose();
    super.dispose();
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
            Container(
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

            Flexible(
              child: Container(),
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Don't have an account?"),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 2),
                ),
                Container(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ],
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
