import 'package:genix/core/cubit/user_cubit/user_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => UserCubit());
}
