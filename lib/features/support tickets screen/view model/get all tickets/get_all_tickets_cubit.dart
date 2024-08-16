import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/tickets_list.dart';
import 'package:genix/features/support%20tickets%20screen/data/repos/tickets_repository.dart';
import 'package:meta/meta.dart';

part 'get_all_tickets_state.dart';

class GetAllTicketsCubit extends Cubit<GetAllTicketsState> {
  GetAllTicketsCubit() : super(GetAllTicketsInitial());

  final TicketsRepository getAllTicketsRepo = TicketsRepository();

  Future<void> getAllTickets() async {
    emit(GetAllTicketsLoading());
    final result = await getAllTicketsRepo.getAllTicketsRepo();
    result.fold(
      (l) => emit(GetAllTicketsError()), // Handle the error case
      (r) {
        final tickets = SupportTicketsList.fromJson(r as Map<String, dynamic>);
        emit(GetAllTicketsSuccess(tickets: tickets)); // Emit success state
      },
    );
  }
}
