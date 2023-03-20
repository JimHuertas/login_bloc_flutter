import 'package:bloc_flutter_login/bloc/user/user_bloc.dart';
import 'package:bloc_flutter_login/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Pagina2Page extends StatelessWidget {
  
  const Pagina2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // MaterialButton(
            //   color: Colors.blue,
            //   child: const Text('Establecer Usuario', style: TextStyle( color: Colors.white ) ),
            //   onPressed: () {
            //     final user = User(
            //       nombre: 'Jim',
            //       number: 22,
            //       email: 'jhuertas@unsa.edu.pe',
            //       password: 'admin123',
            //       profesiones: ['Junior Dev']
            //     );
            //     // BlocProvider.of<UserBloc>(context, listen: false)
            //     userBloc.add(ActiveUser(user));
            //   }
            // ),

            MaterialButton(
              color: Colors.blue,
              child: const Text('Cambiar Numero', style: TextStyle( color: Colors.white ) ),
              onPressed: () {
                const int age = 923104512;
                userBloc.add(ChangeUserAge(age));
              }
            ),

            // MaterialButton(
            //   color: Colors.blue,
            //   child: const Text('Añadir Profesion', style: TextStyle( color: Colors.white ) ),
            //   onPressed: () {
            //     const String newProfesion= 'Rapper';
            //     userBloc.add(AddNewProfession(newProfesion));
            //   }
            // ),

            // MaterialButton(
            //   color: Colors.yellow,
            //   child: const Text('Login Page', style: TextStyle( color: Colors.white ) ),
            //   onPressed: () => Navigator.pushNamed(context, 'login')
            // ),

          ],
        )
     ),
   );
  }
}