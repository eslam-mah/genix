import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_form.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/tickets_model.dart';
import 'package:genix/features/support%20tickets%20screen/data/repos/tickets_repository.dart';
import 'package:meta/meta.dart';

part 'update_ticket_status_state.dart';

class UpdateTicketStatusCubit extends Cubit<UpdateTicketStatusState> {
  UpdateTicketStatusCubit() : super(UpdateTicketStatusInitial());
  final TicketsRepository updateTicketStatusRepo = TicketsRepository();
  Future<void> updateTicket(
      {required TicketForm data,
      required int ticketId,
      required String status}) async {
    emit(UpdateTicketStatusLoading());
    final result = await updateTicketStatusRepo.updateTicketStatus(
        ticketId: ticketId, data: data.toJson(), status: status);
    result.fold((l) => emit(UpdateTicketStatusError()), (r) {
      final ticket = TicketsModel.fromJson(data.toJson());
      emit(UpdateTicketStatusSuccess(ticket: ticket));
    });
  }
}
