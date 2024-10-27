import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/support%20tickets%20screen/data/repos/tickets_repository.dart';
import 'package:meta/meta.dart';

part 'delete_ticket_comment_state.dart';

class DeleteTicketCommentCubit extends Cubit<DeleteTicketCommentState> {
  DeleteTicketCommentCubit() : super(DeleteTicketCommentInitial());
  final TicketsRepository deleteTicketCommentRepo = TicketsRepository();
  Future<void> deleteTicketComment({required int id}) async {
    emit(DeleteTicketCommentLoading());
    final result = await deleteTicketCommentRepo.deleteTicketComment(id: id);
    result.fold((l) => emit(DeleteTicketCommentError()), (r) {
      DeleteTicketCommentSuccess(ticketCommentId: id);
    });
  }
}
