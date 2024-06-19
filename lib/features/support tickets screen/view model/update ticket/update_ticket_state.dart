part of 'update_ticket_cubit.dart';

@immutable
sealed class UpdateTicketState extends Equatable {
  const UpdateTicketState();

  @override
  List<Object> get props => [];
}

final class UpdateTicketInitial extends UpdateTicketState {}

final class UpdateTicketLoading extends UpdateTicketState {}

final class UpdateTicketSuccess extends UpdateTicketState {
  final TicketsModel ticket;
  const UpdateTicketSuccess({required this.ticket});
}

final class UpdateTicketError extends UpdateTicketState {}
