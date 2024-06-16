import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_blocked_users_state.dart';

class GetBlockedUsersCubit extends Cubit<GetBlockedUsersState> {
  GetBlockedUsersCubit() : super(GetBlockedUsersInitial());
}
