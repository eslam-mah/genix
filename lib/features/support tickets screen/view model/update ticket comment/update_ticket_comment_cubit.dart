import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_comment_form.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_form.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_model.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/tickets_model.dart';
import 'package:genix/features/support%20tickets%20screen/data/repos/tickets_repository.dart';
import 'package:meta/meta.dart';

part 'update_ticket_comment_state.dart';

class UpdateTicketCommentCubit extends Cubit<UpdateTicketCommentState> {
  UpdateTicketCommentCubit() : super(UpdateTicketCommentInitial());
  final TicketsRepository updateTicketCommentRepo = TicketsRepository();
  Future<void> updateTicketComment(
      {required TicketCommentForm data, required int id}) async {
    emit(UpdateTicketCommentLoading());
    final result = await updateTicketCommentRepo.updateTicketComment(
        id: id, data: data.toJson());
    result.fold((l) => emit(UpdateTicketCommentError()), (r) {
      final ticketComment = TicketModel.fromJson(data.toJson());
      emit(UpdateTicketCommentSuccess(ticketComment: ticketComment));
    });
  }
}
