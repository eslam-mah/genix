import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'follow_page_state.dart';

class FollowPageCubit extends Cubit<FollowPageState> {
  FollowPageCubit() : super(FollowPageInitial());
}
