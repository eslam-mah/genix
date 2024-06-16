import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_my_restricted_users_state.dart';

class GetMyRestrictedUsersCubit extends Cubit<GetMyRestrictedUsersState> {
  GetMyRestrictedUsersCubit() : super(GetMyRestrictedUsersInitial());
}
