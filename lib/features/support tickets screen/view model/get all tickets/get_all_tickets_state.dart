part of 'get_all_tickets_cubit.dart';

@immutable
sealed class GetAllTicketsState extends Equatable {
  const GetAllTicketsState();

  @override
  List<Object> get props => [];
}

final class GetAllTicketsInitial extends GetAllTicketsState {}

final class GetAllTicketsLoading extends GetAllTicketsState {}

final class GetAllTicketsSuccess extends GetAllTicketsState {
  final TicketsList tickets;
  const GetAllTicketsSuccess({required this.tickets});
}

final class GetAllTicketsError extends GetAllTicketsState {}
