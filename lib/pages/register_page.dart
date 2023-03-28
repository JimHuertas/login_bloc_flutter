import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user/user_bloc.dart';
import '../widgets/blue_button.dart';
import '../widgets/costum_imput.dart';
import '../widgets/labels.dart';
import '../widgets/logo.dart';


class RegisterPage extends StatelessWidget {

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
                  titulo: 'Registro',
                ),
                BlocListener<UserBloc, UserState>(
                  listener: (context, state){
                    (state.status == UserStatus.Authenticated) 
                      ? Navigator.pushReplacementNamed(context, 'pagina1')
                      : null;
                  },
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (_, state){
                      return _Form(state: state);
                    }
                  ),
                ),
                Labels(
                  text: '¿Ya tienes cuenta?',
                  textLinked: 'Ingresar a cuenta',
                  route: 'login',
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
  final state;

  const _Form({super.key, required this.state});

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final numberCtrl = TextEditingController();

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
            hintText: "Nombre",
            prefixIcon: Icons.perm_identity,
            keyboardType: TextInputType.name,
            textController: nameCtrl, 
          ),
          CustomImput(
            hintText: "Correo",
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomImput(
            hintText: "Contraseña",
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            textController: passwordCtrl, 
          ),
          CustomImput(
            hintText: "Número",
            prefixIcon: Icons.contact_phone,
            keyboardType: TextInputType.number,
            textController: numberCtrl, 
          ),

          (widget.state.status != UserStatus.Loading) 
            ? BlueButton(
              emailCtrl: emailCtrl,
              passwordCtrl: passwordCtrl,
              nameCtrl: nameCtrl,
              numberCtrl: numberCtrl,
              text: 'Registrarse',
              onPressed: () {
                userBloc.add(SingUpRequest(emailCtrl.text, passwordCtrl.text, numberCtrl.text, nameCtrl.text));
                print(widget.state.status.toString());
              }
              )
            : const Padding(
              padding: EdgeInsets.all(3.0),
              child: CircularProgressIndicator()
            )
        ],
      ),
    );
  }
}
