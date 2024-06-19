part of 'update_ticket_comment_cubit.dart';

@immutable
sealed class UpdateTicketCommentState extends Equatable {
  const UpdateTicketCommentState();

  @override
  List<Object> get props => [];
}

final class UpdateTicketCommentInitial extends UpdateTicketCommentState {}

final class UpdateTicketCommentLoading extends UpdateTicketCommentState {}

final class UpdateTicketCommentSuccess extends UpdateTicketCommentState {
  final TicketsModel ticketComment;
  const UpdateTicketCommentSuccess({required this.ticketComment});
}

final class UpdateTicketCommentError extends UpdateTicketCommentState {}
