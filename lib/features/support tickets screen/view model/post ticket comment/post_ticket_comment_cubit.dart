import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_comment_form.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_model.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/tickets_model.dart';
import 'package:genix/features/support%20tickets%20screen/data/repos/tickets_repository.dart';
import 'package:meta/meta.dart';

part 'post_ticket_comment_state.dart';

class PostTicketCommentCubit extends Cubit<PostTicketCommentState> {
  PostTicketCommentCubit() : super(PostTicketCommentInitial());
  final TicketsRepository postTicketCommentRepo = TicketsRepository();
  Future<void> postTicketComment(
      {required TicketCommentForm data, required int id}) async {
    emit(PostTicketCommentLoading());
    final result = await postTicketCommentRepo.postTicketComment(
        id: id, data: data.toJson());
    result.fold((l) => emit(PostTicketCommentError()), (r) {
      final ticketComment = TicketModel.fromJson(data.toJson());
      emit(PostTicketCommentSuccess(ticketComment: ticketComment));
    });
  }
}
