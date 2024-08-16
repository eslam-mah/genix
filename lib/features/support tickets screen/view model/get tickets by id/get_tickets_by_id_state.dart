part of 'get_tickets_by_id_cubit.dart';

@immutable
sealed class GetTicketsByIdState extends Equatable {
  const GetTicketsByIdState();

  @override
  List<Object> get props => [];
}

final class GetTicketsByIdInitial extends GetTicketsByIdState {}

final class GetTicketsByIdLoading extends GetTicketsByIdState {}

final class GetTicketsByIdSuccess extends GetTicketsByIdState {
  final TicketsModel tickets;
  const GetTicketsByIdSuccess({required this.tickets});
}

final class GetTicketsByIdError extends GetTicketsByIdState {}
