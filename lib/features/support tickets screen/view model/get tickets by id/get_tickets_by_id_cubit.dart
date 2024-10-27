import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_model.dart';
import 'package:genix/features/support%20tickets%20screen/data/repos/tickets_repository.dart';
import 'package:meta/meta.dart';

part 'get_tickets_by_id_state.dart';

class GetTicketsByIdCubit extends Cubit<GetTicketsByIdState> {
  GetTicketsByIdCubit() : super(GetTicketsByIdInitial());
  final TicketsRepository getTicketByIdRepo = TicketsRepository();
  Future<void> getTicketById({required int id}) async {
    emit(GetTicketsByIdLoading());
    final result = await getTicketByIdRepo.getTicketByIdRepo(id: id);
    result.fold((l) => emit(GetTicketsByIdError()), (r) {
      final tickets = TicketItem.fromJson(r as Map<String, dynamic>);
      emit(GetTicketsByIdSuccess(tickets: tickets));
    });
  }
}
