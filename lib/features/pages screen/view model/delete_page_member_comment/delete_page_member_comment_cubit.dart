import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_page_member_comment_state.dart';

class DeletePageMemberCommentCubit extends Cubit<DeletePageMemberCommentState> {
  DeletePageMemberCommentCubit() : super(DeletePageMemberCommentInitial());
}
