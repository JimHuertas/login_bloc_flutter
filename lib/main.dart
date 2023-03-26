import 'package:bloc_flutter_login/firebase_options.dart';
import 'package:bloc_flutter_login/models/user_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:bloc_flutter_login/bloc/user/user_bloc.dart';
import 'package:bloc_flutter_login/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  final authRepository = AuthRepository(); 
  runApp(MyApp(authRepository: authRepository));
}
 
class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  const MyApp({
    Key? key, 
    required AuthRepository authRepository
  }): _authRepository = authRepository, super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => UserBloc(authRepository: _authRepository),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Login Bloc',
          initialRoute: 'home',
          routes: appRoutes
        )
      )
    );
  }
}