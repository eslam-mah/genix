import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_page_member_post_state.dart';

class DeletePageMemberPostCubit extends Cubit<DeletePageMemberPostState> {
  DeletePageMemberPostCubit() : super(DeletePageMemberPostInitial());
}
