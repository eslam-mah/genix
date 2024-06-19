import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/support%20tickets%20screen/data/repos/tickets_repository.dart';
import 'package:meta/meta.dart';

part 'delete_ticket_state.dart';

class DeleteTicketCubit extends Cubit<DeleteTicketState> {
  DeleteTicketCubit() : super(DeleteTicketInitial());
  final TicketsRepository deleteTicketRepo = TicketsRepository();
  Future<void> deleteTicket({required String id}) async {
    emit(DeleteTicketLoading());
    final result = await deleteTicketRepo.deleteTicket(id: id);
    result.fold((l) => emit(DeleteTicketError()), (r) {
      DeleteTicketSuccess(ticketId: id);
    });
  }
}
