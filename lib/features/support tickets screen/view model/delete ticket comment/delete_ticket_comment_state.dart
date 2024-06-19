part of 'delete_ticket_comment_cubit.dart';

@immutable
sealed class DeleteTicketCommentState extends Equatable {
  const DeleteTicketCommentState();

  @override
  List<Object> get props => [];
}

final class DeleteTicketCommentInitial extends DeleteTicketCommentState {}

final class DeleteTicketCommentLoading extends DeleteTicketCommentState {}

final class DeleteTicketCommentSuccess extends DeleteTicketCommentState {
  final String ticketCommentId;
  const DeleteTicketCommentSuccess({required this.ticketCommentId});
}

final class DeleteTicketCommentError extends DeleteTicketCommentState {}
