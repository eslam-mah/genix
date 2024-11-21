part of 'add_poll_cubit.dart';

sealed class AddPollState extends Equatable {
  const AddPollState();

  @override
  List<Object> get props => [];
}

final class AddPollInitial extends AddPollState {}

final class AddPollLoading extends AddPollState {}

final class AddPollSuccess extends AddPollState {
  final String post;
  const AddPollSuccess({required this.post});
}

final class AddPollError extends AddPollState {}
