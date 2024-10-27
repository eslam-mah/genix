import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_form.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_model.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/tickets_model.dart';
import 'package:genix/features/support%20tickets%20screen/data/repos/tickets_repository.dart';
import 'package:meta/meta.dart';

part 'post_ticket_state.dart';

class PostTicketCubit extends Cubit<PostTicketState> {
  PostTicketCubit() : super(PostTicketInitial());
  final TicketsRepository postTicketRepo = TicketsRepository();
  Future<void> postTicket({required TicketForm data}) async {
    emit(PostTicketLoading());
    final result = await postTicketRepo.postTicket(data: data.toJson());
    result.fold((l) => emit(PostTicketError()), (r) {
      final ticket = TicketsModel.fromJson(data.toJson());
      emit(PostTicketSuccess(ticket: ticket));
    });
  }
}
