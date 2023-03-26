
import 'package:bloc_flutter_login/pages/image_generation.dart';
import 'package:flutter/material.dart';
import 'package:bloc_flutter_login/pages/pagina1_page.dart';
import 'package:bloc_flutter_login/pages/pagina2_page.dart';

import '../pages/home_page.dart';
import '../pages/login.dart';
import '../pages/register.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'pagina1' : (_) => const Pagina1Page(),
  'pagina2' : (_) => const Pagina2Page(),
  'image_gen'  : ( _ ) => ImageGenerationPage(),
  'home'      : ( _ ) => const HomePage(),
  'login'     : ( _ ) => LoginPage(),
  'register'  : ( _ ) => RegisterPage(),
  // 'loading'   : ( _ ) => LoadingPage(),
};