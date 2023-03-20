import 'package:flutter/material.dart';

import 'package:bloc_flutter_login/bloc/user/user_bloc.dart';
import 'package:bloc_flutter_login/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 
void main() => runApp( const MyApp());
 
class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bloc Login',
        initialRoute: 'login',
        routes: appRoutes
      ),
    );
  }
}