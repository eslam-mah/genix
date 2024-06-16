import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'restrict_user_state.dart';

class RestrictUserCubit extends Cubit<RestrictUserState> {
  RestrictUserCubit() : super(RestrictUserInitial());
}
