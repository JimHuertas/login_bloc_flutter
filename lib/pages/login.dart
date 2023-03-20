import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user/user_bloc.dart';
import '../widgets/blue_button.dart';
import '../widgets/costum_imput.dart';
import '../widgets/labels.dart';
import '../widgets/logo.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height*0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Logo(
                  titulo: 'Messenger',
                ),
                
                _Form(),
              
                Labels(
                  text: '¿No tienes cuenta?',
                  textLinked: 'Crea una cuenta ahora!',
                  route: 'register',
                ),
                const Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),)
              ],
            ),
          ),
        ),
      ),
   );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CustomImput(
            hintText: "Correo",
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomImput(
            hintText: "Contraseña",
            textController: passwordCtrl, 
            prefixIcon: Icons.lock_outline,
            obscureText: true,
          ),

          BlueButton(
            emailCtrl: emailCtrl,
            passwordCtrl: passwordCtrl,
            text: 'Ingresar',
            onPressed: () {
              userBloc.add(ValidLogin(emailCtrl.text, passwordCtrl.text));
              
              (userBloc.state.existUser) ?
              // print("logeado") : print("no hay usuario");
              Navigator.pushReplacementNamed(context, 'pagina1') : null;
              
            }
          )
        ],
      ),
    );
  }
}
