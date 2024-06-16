import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_restricted_users_state.dart';

class GetRestrictedUsersCubit extends Cubit<GetRestrictedUsersState> {
  GetRestrictedUsersCubit() : super(GetRestrictedUsersInitial());
}
