import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_page_member_state.dart';

class DeletePageMemberCubit extends Cubit<DeletePageMemberState> {
  DeletePageMemberCubit() : super(DeletePageMemberInitial());
}
