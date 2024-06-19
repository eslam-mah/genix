part of 'post_ticket_cubit.dart';

@immutable
sealed class PostTicketState extends Equatable {
  const PostTicketState();

  @override
  List<Object> get props => [];
}

final class PostTicketInitial extends PostTicketState {}

final class PostTicketLoading extends PostTicketState {}

final class PostTicketSuccess extends PostTicketState {
  final TicketsModel ticket;
  const PostTicketSuccess({required this.ticket});
}

final class PostTicketError extends PostTicketState {}
