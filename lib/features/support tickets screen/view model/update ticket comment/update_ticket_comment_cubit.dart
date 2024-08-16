import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_form.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/tickets_model.dart';
import 'package:genix/features/support%20tickets%20screen/data/repos/tickets_repository.dart';
import 'package:meta/meta.dart';

part 'update_ticket_comment_state.dart';

class UpdateTicketCommentCubit extends Cubit<UpdateTicketCommentState> {
  UpdateTicketCommentCubit() : super(UpdateTicketCommentInitial());
  final TicketsRepository updateTicketCommentRepo = TicketsRepository();
  Future<void> updateTicketComment(
      {required TicketForm data, required int id}) async {
    emit(UpdateTicketCommentLoading());
    final result = await updateTicketCommentRepo.updateTicketComment(
        id: id, data: data.toJson());
    result.fold((l) => emit(UpdateTicketCommentError()), (r) {
      final ticketComment = TicketsModel.fromJson(data.toJson());
      emit(UpdateTicketCommentSuccess(ticketComment: ticketComment));
    });
  }
}
