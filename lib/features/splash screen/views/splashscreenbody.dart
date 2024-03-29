import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:genix/features/login%20screen/loginscreen.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  void initState() {
    super.initState();

    goToAuth();
  }

  void goToAuth() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).push(NextPage());
    });
  }

  // ignore: non_constant_identifier_names
  Route NextPage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const LogIn(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = 0.0;
        var end = 1.0;
        var curve = Curves.easeIn;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var fadedAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: fadedAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff01924F),
      body: Center(
        child: SizedBox(
          width: 110.w,
          height: 110.h,
          child: Image.asset('assets/icons/gen.png'),
        ),
      ),
    );
  }
}
