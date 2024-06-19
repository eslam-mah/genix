part of 'delete_ticket_cubit.dart';

@immutable
sealed class DeleteTicketState extends Equatable {
  const DeleteTicketState();

  @override
  List<Object> get props => [];
}

final class DeleteTicketInitial extends DeleteTicketState {}

final class DeleteTicketLoading extends DeleteTicketState {}

final class DeleteTicketSuccess extends DeleteTicketState {
  final String ticketId;
  const DeleteTicketSuccess({required this.ticketId});
}

final class DeleteTicketError extends DeleteTicketState {}
