import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_page_member_state.dart';

class UpdatePageMemberCubit extends Cubit<UpdatePageMemberState> {
  UpdatePageMemberCubit() : super(UpdatePageMemberInitial());
}
