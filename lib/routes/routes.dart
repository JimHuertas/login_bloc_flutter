
import 'package:bloc_flutter_login/pages/image_generation_page.dart';
import 'package:flutter/material.dart';
import 'package:bloc_flutter_login/pages/generator_page.dart';
import 'package:bloc_flutter_login/pages/pagina2_page.dart';

import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'pagina1' : (_) => const GeneratorPage(),
  'pagina2' : (_) => const Pagina2Page(),
  'image_gen'  : ( _ ) => const ImageGenerationPage(),
  'home'      : ( _ ) => const HomePage(),
  'login'     : ( _ ) => const LoginPage(),
  'register'  : ( _ ) => const RegisterPage(),
  // 'verif_number'   : ( _ ) => const VerificationNumber(),
};