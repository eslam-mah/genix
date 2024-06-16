import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_user_detaile_state.dart';

class UpdateUserDetaileCubit extends Cubit<UpdateUserDetaileState> {
  UpdateUserDetaileCubit() : super(UpdateUserDetaileInitial());
}
