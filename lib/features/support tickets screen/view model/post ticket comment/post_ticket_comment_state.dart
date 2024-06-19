part of 'post_ticket_comment_cubit.dart';

@immutable
sealed class PostTicketCommentState extends Equatable {
  const PostTicketCommentState();

  @override
  List<Object> get props => [];
}

final class PostTicketCommentInitial extends PostTicketCommentState {}

final class PostTicketCommentLoading extends PostTicketCommentState {}

final class PostTicketCommentSuccess extends PostTicketCommentState {
  final TicketsModel ticketComment;
  const PostTicketCommentSuccess({required this.ticketComment});
}

final class PostTicketCommentError extends PostTicketCommentState {}
