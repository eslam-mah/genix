part of 'update_ticket_status_cubit.dart';

@immutable
sealed class UpdateTicketStatusState extends Equatable {
  const UpdateTicketStatusState();

  @override
  List<Object> get props => [];
}

final class UpdateTicketStatusInitial extends UpdateTicketStatusState {}

final class UpdateTicketStatusLoading extends UpdateTicketStatusState {}

final class UpdateTicketStatusSuccess extends UpdateTicketStatusState {
  final TicketsModel ticket;
  const UpdateTicketStatusSuccess({required this.ticket});
}

final class UpdateTicketStatusError extends UpdateTicketStatusState {}
