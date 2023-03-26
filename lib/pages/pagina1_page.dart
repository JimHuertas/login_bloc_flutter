import 'package:bloc_flutter_login/bloc/user/user_bloc.dart';
import 'package:bloc_flutter_login/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as FBAuth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Pagina1Page extends StatelessWidget {

  const Pagina1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (_, state) { 
          return (state.status == UserStatus.Authenticated) 
            ? const InformacionUsuario()
            : const Center(
              child: Text('Usuario No Encontrado'),
            );
        },

      ),

     floatingActionButton: FloatingActionButton(
       child: const Icon( Icons.accessibility_new ),
       onPressed: () => Navigator.pushNamed(context, 'image_gen')
     ),
   );
  }
}

class InformacionUsuario extends StatelessWidget {

  const InformacionUsuario({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final res = FBAuth.FirebaseAuth.instance;
    final user = res.currentUser;
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text('General', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ) ),
          const Divider(),

          ListTile( title: Text(
            'Nombre: ${user!.displayName}'
          ) ),
          ListTile( title: Text('Numero: ${user.phoneNumber}') ),
          ListTile( title: Text('Email: ${user.email}') ),

          // const Text('Profesiones', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ) ),
          // const Divider(),

          // ...user.profesiones.map(
          //   (prof) => ListTile(title: Text(prof))
          // ).toList(),

        ],
      ),
    );
  }

}