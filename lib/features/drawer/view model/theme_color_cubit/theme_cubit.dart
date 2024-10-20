import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/pref_keys.dart';

enum ThemeState { light, dark }

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(CacheData.getData(key: PrefKeys.kDarkMode) ?? false
            ? ThemeState.dark
            : ThemeState.light);

  void toggleTheme() {
    if (state == ThemeState.light) {
      emit(ThemeState.dark);
      CacheData.setData(key: PrefKeys.kDarkMode, value: true);
    } else if (state == ThemeState.dark) {
      emit(ThemeState.light);
      CacheData.setData(key: PrefKeys.kDarkMode, value: false);
    }
  }
}
