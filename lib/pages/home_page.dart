import 'package:bloc_flutter_login/pages/login.dart';
import 'package:bloc_flutter_login/pages/pagina1_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user/user_bloc.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context, listen: false);
    return (userBloc.state.status == UserStatus.Authenticated)
    ? const Pagina1Page()
    : LoginPage();
  }
}