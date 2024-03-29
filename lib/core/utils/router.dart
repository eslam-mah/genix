import 'package:genix/features/login%20screen/loginscreen.dart';
import 'package:genix/features/splash%20screen/splashscreen.dart';
import 'package:go_router/go_router.dart';

abstract class Rout {
  static const kLogIn = '/login';
  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: kLogIn,
      builder: (context, state) => const LogIn(),
    ),
  ]);
}
