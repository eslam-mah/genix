import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/router.dart';

void main() {
  runApp(const Genix());
}

class Genix extends StatelessWidget {
  const Genix({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            theme: ThemeData.light(),
            routerConfig: Rout.router,
            debugShowCheckedModeBanner: false,
          );
        });
  }
}