import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'remove_follow_page_state.dart';

class RemoveFollowPageCubit extends Cubit<RemoveFollowPageState> {
  RemoveFollowPageCubit() : super(RemoveFollowPageInitial());
}
