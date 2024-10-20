import 'package:bloc/bloc.dart';

import '../../../features/profile screen/data/profile_model/user.dart';

class UserCubit extends Cubit<User> {
  UserCubit() : super(const User());

  void setUser(User user) => emit(user);
}
