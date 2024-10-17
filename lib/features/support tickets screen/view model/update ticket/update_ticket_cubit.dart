import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_form.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/tickets_model.dart';
import 'package:genix/features/support%20tickets%20screen/data/repos/tickets_repository.dart';
import 'package:meta/meta.dart';

part 'update_ticket_state.dart';

class UpdateTicketCubit extends Cubit<UpdateTicketState> {
  UpdateTicketCubit() : super(UpdateTicketInitial());
  final TicketsRepository updateTicketRepo = TicketsRepository();
  Future<void> updateTicket({required TicketForm data, required int id}) async {
    emit(UpdateTicketLoading());
    final result =
        await updateTicketRepo.updateTicket(id: id, data: data.toJson());
    result.fold((l) => emit(UpdateTicketError()), (r) {
      final ticket = TicketsModel.fromJson(data.toJson());
      emit(UpdateTicketSuccess(ticket: ticket));
    });
  }
}
