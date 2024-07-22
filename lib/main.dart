import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/features/splash%20screen/view%20model/first%20load/first_load_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheData.cacheInitialization();
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
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => FirstLoadCubit(),
              )
            ],
            child: MaterialApp.router(
              theme: ThemeData.light()
                  .copyWith(primaryColor: AppColors.kPrimaryColor),
              routerConfig: Rout.router,
              debugShowCheckedModeBanner: false,
            ),
          );
        });
  }
}
